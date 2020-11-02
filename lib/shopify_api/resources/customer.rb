# frozen_string_literal: true
module ShopifyAPI
  class Customer < Base
    include Metafields

    def orders
      Order.find(:all, params: { customer_id: self.id })
    end

    def self.search(params)
      find(:all, from: :search, params: params)
    end

    def account_activation_url
      resource = post(:account_activation_url, {}, only_id)
      data = ActiveSupport::JSON.decode(resource.body.to_s)
      result = nil

      if data.key?('account_activation_url')
        result = data['account_activation_url']
      end
      result
    end

    def send_invite(customer_invite = ShopifyAPI::CustomerInvite.new)
      resource = post(:send_invite, {}, customer_invite.encode)
      ShopifyAPI::CustomerInvite.new(ShopifyAPI::CustomerInvite.format.decode(resource.body))
    end
  end
end
