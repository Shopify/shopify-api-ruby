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
        delegate :body, :code, :headers, :prev_page_info, :next_page_info, to: :@http_response

        # TODO: GRAPHQL_TODO
        # Do we want to map `:errors` method to user errors from response body if it exists?
        # e.g.
        # mutation ($input: ProductInput!) {
        #  createProduct(input: $input) {
        #    id
        #  }
        #  userErrors {
        #    field
        #    message
        #  }
        # }
        # Right now if there are userErrors returned from the mutation, we don't do anything with it, user would have to query for it
        # Do we want to parse it and return the error from `:errors` so that it's easier for user to see the errors?
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
