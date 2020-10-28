# frozen_string_literal: true
module ShopifyAPI
  class ApplicationCharge < Base
    undef_method :test

    class << self
      [:pending, :expired, :accepted, :declined].each do |status|
        define_method(status) { (all || []).select { |c| c.status == status.to_s } }
      end
    end

    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
