# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    class HttpResponse < T::Struct
      extend T::Sig

      prop :code, Integer
      prop :headers, T::Hash[String, T::Array[String]]
      prop :body, T.any(T::Hash[String, T.untyped], String)

      sig { returns(T::Boolean) }
      def ok?
        code >= 200 && code <= 299
      end
    end
  end
end
