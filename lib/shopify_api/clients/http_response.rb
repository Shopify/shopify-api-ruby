# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    class HttpResponse
      extend T::Sig

      sig { returns(Integer) }
      attr_reader :code

      sig { returns(T::Hash[String, T::Array[String]]) }
      attr_reader :headers

      sig { returns(T.any(T::Hash[String, T.untyped], String, OpenStruct)) }
      attr_reader :body

      sig { returns(T.nilable(String)) }
      attr_reader :prev_page_info, :next_page_info

      sig do
        params(
          code: Integer,
          headers: T::Hash[String, T::Array[String]],
          body: T.any(T::Hash[String, T.untyped], String),
        ).void
      end
      def initialize(code:, headers:, body:)
        @code = code
        @headers = headers
        @body = T.let(body, T.any(OpenStruct, T::Hash[String, T.untyped], String))

        if Context.graphql_response_object && body.is_a?(Hash)
          json_body = body.to_json
+         @body = JSON.parse(json_body, object_class: OpenStruct)
        end

        @prev_page_info = T.let(nil, T.nilable(String))
        @next_page_info = T.let(nil, T.nilable(String))
        @prev_page_info, @next_page_info = parse_link_header
      end

      sig { returns(T::Boolean) }
      def ok?
        code >= 200 && code <= 299
      end

      private

      sig { returns(T::Array[T.nilable(String)]) }
      def parse_link_header
        return [nil, nil] if @headers["link"].nil?

        page_info = {}
        T.must(T.must(@headers["link"])[0]).split(",").each do |link|
          rel = T.must(link.match(/rel="(.*?)"/))[1]
          url = T.must(T.must(link.match(/<(.*?)>/))[1])

          T.must(URI.parse(url).query).split("&").each do |param|
            if param.split("=")[0] == "page_info"
              page_info[rel] = param.split("=")[1]
              break
            end
          end
        end

        [page_info["previous"], page_info["next"]]
      end
    end
  end
end
