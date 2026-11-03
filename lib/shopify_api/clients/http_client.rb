# typed: strict
# frozen_string_literal: true

require "time"

module ShopifyAPI
  module Clients
    class HttpClient
      extend T::Sig

      RETRY_WAIT_TIME = 1

      sig { params(base_path: String, session: T.nilable(Auth::Session)).void }
      def initialize(base_path:, session: nil)
        session ||= Context.active_session
        raise Errors::NoActiveSessionError, "No passed or active session" unless session

        api_host = Context.api_host

        @base_uri = T.let("https://#{api_host || session.shop}", String)
        @base_uri_and_path = T.let("#{@base_uri}#{base_path}", String)

        user_agent_prefix = Context.user_agent_prefix.nil? ? "" : "#{Context.user_agent_prefix} | "

        @headers = T.let({
          "User-Agent": "#{user_agent_prefix}Shopify API Library v#{VERSION} | Ruby #{RUBY_VERSION}",
          "Accept": "application/json",
        }, T::Hash[T.any(Symbol, String), T.untyped])

        @headers["Host"] = session.shop unless api_host.nil?

        unless session.access_token.nil? || T.must(session.access_token).empty?
          @headers["X-Shopify-Access-Token"] = T.cast(session.access_token, String)
        end
      end

      sig do
        params(
          request: HttpRequest,
          response_as_struct: T::Boolean,
        ).returns(HttpResponse)
      end
      def request(request, response_as_struct: false)
        request.verify

        headers = @headers.dup
        headers["Content-Type"] = T.must(request.body_type) if request.body_type
        headers = headers.merge(T.must(request.extra_headers)) if request.extra_headers

        parsed_uri = URI(request_url(request))

        headers = append_first_party_development_headers(headers, parsed_uri)

        tries = 0
        response = HttpResponse.new(code: 0, headers: {}, body: "")
        while tries < request.tries
          tries += 1
          request_options = {
            headers: headers,
            query: request.query,
            body: request.body.class == Hash ? T.unsafe(request.body).to_json : request.body,
          }
          request_options[:follow_redirects] = request.follow_redirects unless request.follow_redirects.nil?

          if request.suppress_inherited_http_auth
            verify_no_url_credentials!(parsed_uri)
            request_options.merge!(basic_auth: nil, digest_auth: nil)
          end

          res = T.cast(HTTParty.send(
            request.http_method,
            parsed_uri.to_s,
            **request_options,
          ), HTTParty::Response)

          if request.follow_redirects == false && res.code.to_i.between?(300, 399)
            blocked_response = HttpResponse.new(code: res.code.to_i, headers: res.headers.to_h, body: res.body.to_s)
            raise ShopifyAPI::Errors::HttpResponseError.new(response: blocked_response),
              blocked_redirect_message(res)
          end

          begin
            body = res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
          rescue JSON::ParserError
            raise if res.code.to_i < 500

            body = res.body
          end

          graphql_throttled = request.retry_on_graphql_throttled && graphql_throttled?(body)
          graphql_retry_wait_time = T.let(nil, T.nilable(Integer))
          if graphql_throttled && tries < request.tries
            graphql_retry_wait_time = graphql_throttle_retry_wait_time(T.cast(body, T::Hash[String, T.untyped]))
          end

          if response_as_struct && body.is_a?(Hash)
            json_body = body.to_json
            body = JSON.parse(json_body, object_class: OpenStruct)
          end

          response = HttpResponse.new(code: res.code.to_i, headers: res.headers.to_h, body: body)

          if response.headers["x-shopify-api-deprecated-reason"]
            reason = T.must(response.headers["x-shopify-api-deprecated-reason"])[0]
            Context.logger.warn("Deprecated request to Shopify API at #{request.path}, received reason: #{reason}")
          end

          if response.ok?
            break unless graphql_throttled
            break if tries == request.tries

            sleep(T.must(graphql_retry_wait_time))
            next
          end

          error_message = serialized_error(response)

          unless [429, 500].include?(response.code)
            raise ShopifyAPI::Errors::HttpResponseError.new(response: response), error_message
          end

          if tries == request.tries
            raise ShopifyAPI::Errors::HttpResponseError.new(response: response), error_message if request.tries == 1

            raise ShopifyAPI::Errors::MaxHttpRetriesExceededError.new(response: response),
              "Exceeded maximum retry count of #{request.tries}. Last message: #{error_message}"
          end

          if response.code == 500 || response.headers["retry-after"].nil?
            sleep(RETRY_WAIT_TIME)
          else
            sleep(T.must(response.headers["retry-after"])[0].to_i)
          end
        end

        response
      end

      protected

      sig { params(request: HttpRequest).returns(String) }
      def request_url(request)
        "#{@base_uri_and_path}/#{request.path}"
      end

      sig { params(response: HttpResponse).returns(String) }
      def serialized_error(response)
        body = {}
        # Only a parsed JSON object has error members. On an unparsed body `response.body["errors"]` is
        # `String#[]`, so an HTML page containing the word "errors" would report `{"errors":"errors"}`.
        if response.body.is_a?(Hash)
          error_body = T.cast(response.body, T::Hash[String, T.untyped])
          body["errors"] = error_body["errors"] if error_body["errors"]
          body["error"] = error_body["error"] if error_body["error"]
          body["error_description"] = error_body["error_description"] if error_body["error_description"]
        end

        if response.headers["x-request-id"]
          id = T.must(response.headers["x-request-id"])[0]
          body["error_reference"] = "If you report this error, please include this id: #{id}."
        end
        body.to_json
      end

      private

      sig { params(body: T.untyped).returns(T::Boolean) }
      def graphql_throttled?(body)
        return false unless body.is_a?(Hash)

        errors = body["errors"]
        return false unless errors.is_a?(Array)

        errors.any? do |error|
          error.is_a?(Hash) && error.dig("extensions", "code") == "THROTTLED"
        end
      end

      sig { params(body: T::Hash[String, T.untyped]).returns(Integer) }
      def graphql_throttle_retry_wait_time(body)
        errors = body["errors"]
        throttle_error = errors.find do |error|
          error.is_a?(Hash) && error.dig("extensions", "code") == "THROTTLED"
        end
        reset_at = throttle_error&.dig("extensions", "cost", "windowResetAt")
        if reset_at.is_a?(String)
          begin
            return [(Time.iso8601(reset_at) - Time.now).ceil, RETRY_WAIT_TIME].max
          rescue ArgumentError
            # Fall back to the shared GraphQL cost budget when the reset time is malformed.
          end
        end

        cost = body.dig("extensions", "cost")
        throttle_status = cost.is_a?(Hash) ? cost["throttleStatus"] : nil
        requested_cost = cost.is_a?(Hash) ? cost["requestedQueryCost"] : nil
        available_cost = throttle_status.is_a?(Hash) ? throttle_status["currentlyAvailable"] : nil
        restore_rate = throttle_status.is_a?(Hash) ? throttle_status["restoreRate"] : nil

        unless requested_cost.is_a?(Numeric) && available_cost.is_a?(Numeric) &&
            restore_rate.is_a?(Numeric) && restore_rate.positive?
          return RETRY_WAIT_TIME
        end

        [((requested_cost - available_cost).to_f / restore_rate).ceil, RETRY_WAIT_TIME].max
      end

      # A redirect on a credential-bearing request is the one error here a developer cannot diagnose from
      # the status alone, so it says what happened, what was not sent, and what to check.
      sig { params(res: HTTParty::Response).returns(String) }
      def blocked_redirect_message(res)
        location = res.headers["location"]
        target = location.nil? || location.empty? ? "an unnamed location" : location

        "Refused to follow the #{res.code} redirect to #{target}, because this request was sent with " \
          "redirects disabled: following it would forward the request body, and any credentials in it, to " \
          "the redirect target. Nothing was sent there. Check any proxy or ShopifyAPI::Context.api_host " \
          "configuration in front of the endpoint, and retry with a newly created client assertion if you " \
          "are using one."
      end

      # HTTParty's `set_basic_auth_from_uri` rebuilds `basic_auth` from the URL after an explicit `nil`
      # override, so suppressing inherited authentication is not enough on its own.
      sig { params(parsed_uri: URI::Generic).void }
      def verify_no_url_credentials!(parsed_uri)
        return unless parsed_uri.userinfo

        raise ShopifyAPI::Errors::InvalidHttpRequestError,
          "Cannot send a request with HTTP authentication disabled to a URL containing credentials."
      end

      sig do
        params(
          headers: T::Hash[T.any(Symbol, String), T.untyped],
          parsed_uri: URI::Generic,
        ).returns(T::Hash[T.any(Symbol, String), T.untyped])
      end
      def append_first_party_development_headers(headers, parsed_uri)
        return headers unless defined?(DevServer)
        return headers unless headers["Host"]&.include?(".my.shop.dev") || parsed_uri.host&.include?(".my.shop.dev")
        return headers if headers["x-forwarded-host"]&.include?(".my.shop.dev")

        # These headers are only used for first party applications in development mode
        headers["x-forwarded-host"] = headers["Host"] || parsed_uri.host
        headers["Host"] = T.unsafe(
          Object.const_get("DevServer::Core"), # rubocop:disable Sorbet/ConstantsFromStrings
        ).new.host!(:app)

        headers
      end
    end
  end
end
