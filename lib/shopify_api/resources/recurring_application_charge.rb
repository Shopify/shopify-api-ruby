# frozen_string_literal: true
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

    def usage_charges
      UsageCharge.find(:all, params: { recurring_application_charge_id: id })
    end

    def cancel
      load_attributes_from_response(self.destroy)
    end

    def activate
      load_attributes_from_response(post(:activate))
    end

    def customize(customize_recurring_app_charge_params = {})
      load_attributes_from_response(
        put(:customize, recurring_application_charge: customize_recurring_app_charge_params)
      )
    end
  end
end
