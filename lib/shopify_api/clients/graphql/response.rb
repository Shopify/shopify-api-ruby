# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Response
        extend T::Sig

        # TODO: GRAPHQL_TODO
        # Intention here is to make sure the response we return is compatible with both
        # graphql-client gem's response and our HTTPResponse pattern
        # Determine if this is necessary, could we just depend strictly on graphq-client's response?
        # it seems like we get `next_page_info` and `prev_page_info` from the HTTP Response headers
        # that's why I made the decision to use our HttpResponse class to parse the headers to get this
        # behavior for free
        delegate :code, :headers, :prev_page_info, :next_page_info, to: :@http_response
        delegate :original_hash, :data, :errors, :extensions, to: :@graphql_client_response

        sig { params(response: GraphQL::Client::Response).void }
        def initialize(response:)
          @graphql_client_response = response
          @http_response = HttpResponse.new(
            code: @graphql_client_response.original_hash["response_code"],
            headers: @graphql_client_response.original_hash["response_headers"],
            body: @graphql_client_response.original_hash["response_body"],
          )
        end
      end
    end
  end
end
