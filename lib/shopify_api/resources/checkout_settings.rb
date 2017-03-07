module ShopifyAPI
  class CheckoutSettings < Base
    self.prefix = '/admin/settings'
    self.element_name = ''
    self.primary_key = ''

    def self.current(options = {})
      find(:one, options.merge(from: "/admin/settings/checkout.json"))
    end

    def save
      checkout_configuration = attributes.reject { |k| k == "id" }
      body = { "shop" => { "checkout_configuration" => checkout_configuration } }
      put(:checkout, {}, body.to_json)
    end

    def update(params)
      checkout_configuration = params.reject { |k| k == "id" }
      body = { "shop" => { "checkout_configuration" => checkout_configuration } }
      put(:checkout, {}, body.to_json)
    end
  end
end