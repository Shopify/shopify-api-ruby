# frozen_string_literal: true

module ShopifyAPI
  class ArrayBase < Base
    class << self
      private

      def instantiate_record(record, *)
        record
      end
    end
  end
end
