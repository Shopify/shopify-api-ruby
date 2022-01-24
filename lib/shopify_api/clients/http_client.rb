# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    class HttpClient
      extend T::Sig

      RETRY_WAIT_TIME = 1

      sig { params(base_path: String, session: T.nilable(Auth::Session)).void }
      def initialize(base_path:, session: nil)
        session ||= Context.active_session
        raise Errors::NoActiveSessionError, "No passed or active session" unless session

        @base_uri = T.let("https://#{session.shop}#{base_path}", String)

        @headers = T.let({
          "User-Agent": "Shopify API Library v#{VERSION} | Ruby #{RUBY_VERSION}",
          "Accept": "application/json",
        }, T::Hash[T.any(Symbol, String), T.untyped])

        unless session.access_token.nil? || T.must(session.access_token).empty?
          @headers["X-Shopify-Access-Token"] = T.cast(session.access_token, String)
        end
      end

      sig { params(request: HttpRequest).returns(HttpResponse) }
      def request(request)
        request.verify

        headers = @headers
        headers["Content-Type"] = T.must(request.body_type) if request.body_type
        headers = headers.merge(T.must(request.extra_headers)) if request.extra_headers

        tries = 0
        response = HttpResponse.new(code: 0, headers: {}, body: "")
        while tries < request.tries
          tries += 1
          res = T.cast(HTTParty.send(
            request.http_method,
            "#{@base_uri}/#{request.path}",
            headers: headers,
            query: request.query,
            body: request.body.class == Hash ? T.unsafe(request.body).to_json : request.body
          ), HTTParty::Response)

          body = res.body.empty? ? {} : JSON.parse(res.body)
          response = HttpResponse.new(code: res.code.to_i, headers: res.headers.to_h, body: body)

          if response.headers["x-shopify-api-deprecated-reason"]
            reason = T.must(response.headers["x-shopify-api-deprecated-reason"])[0]
            Context.logger.warn("Deprecated request to Shopify API at #{request.path}, received reason: #{reason}")
          end

          break if response.ok?

          error_messages = []
          error_messages << response.body["errors"] if response.body["errors"]

          if response.headers["x-request-id"]
            id = T.must(response.headers["x-request-id"])[0]
            error_messages << "If you report this error, please include this id: #{id}."
          end

          error_message = error_messages.join("\n")

          unless [429, 500].include?(response.code)
            raise ShopifyAPI::Errors::HttpResponseError.new(code: response.code.to_i), error_message
          end

          if tries == request.tries
            raise ShopifyAPI::Errors::HttpResponseError.new(code: response.code), error_message if request.tries == 1
            raise ShopifyAPI::Errors::MaxHttpRetriesExceededError.new(code: response.code),
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
    end
  end
end
