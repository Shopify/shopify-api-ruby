# frozen_string_literal: true
module FulfillmentOrderTestHelper
  def url_prefix_for_activated_session_for(version)
    available_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: version)
    ShopifyAPI::Base.activate_session(available_version)
    "https://shop2.myshopify.com/admin/api/#{version}"
  end
end
