module ShopifyAPI
  class RecurringApplicationCharge < Base
    undef_method :test

    class << self
      def current
        (all || []).find { |c| c.status == 'active' }
      end

      [:pending, :cancelled, :accepted, :declined].each do |status|
        define_method(status) { (all || []).select { |c| c.status == status.to_s } }
      end
    end

    def cancel
      load_attributes_from_response(self.destroy)
    end

    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
