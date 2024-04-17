# typed: strict
# frozen_string_literal: true

require "active_support/core_ext/hash"

module ShopifyAPI
  module Utils
    module OstructHashUtils
      class << self
        extend T::Sig

        sig { params(object: OpenStruct, hash: T::Hash).returns(T::Hash[String, T.untyped]) }
        def open_struct_to_hash(object, hash = {})
          object.each_pair do |key, value|
            hash[key] = case value
                        when OpenStruct then open_struct_to_hash(value)
                        when Array then value.map { |v| v.is_a?(OpenStruct) ? open_struct_to_hash(v) : v }
                        else value
                        end
          end
          hash.deep_stringify_keys
        end

        sig { params(obj: T.any(Hash, OpenStruct)).returns(T::Hash[String, T.untyped]) }
        def ensure_hash(obj)
          case obj
          when Hash
            obj
          when OpenStruct
            open_struct_to_hash(obj)
          else
            raise ArgumentError, "Expected Hash or OpenStruct, got #{obj.class}"
          end
        end

      end
    end
  end
end
