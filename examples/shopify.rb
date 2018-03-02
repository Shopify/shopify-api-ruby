class Shopify
  attr_reader :client

  def initialize(account)
    @client = account
  end

  def shop
    ShopifyAPI::Session.temp(@client.uid, @client.access_token){ ShopifyAPI::Shop.current }
  end
  
  def revoke_shop
    ShopifyAPI::Base.clear_session
  end

  def fetch_all_orders
    ShopifyAPI::Session.temp(@client.uid, @client.access_token) { ShopifyAPI::Order.find(:all) }
  end

  def fetch_specific_order(order_id)
    ShopifyAPI::Session.temp(@client.uid, @client.access_token) { ShopifyAPI::Order.find(order_id) }
  end

  def create_fulfillment(order_id, tracking_numbers, tracking_links, shipping_company)
    session = ShopifyAPI::Session.new(@client.uid, @client.access_token)
    ShopifyAPI::Base.activate_session(session)
    
    fulfill = ShopifyAPI::Fulfillment.new( :params => {:order_id => order_id})
    fulfill.tracking_numbers = tracking_numbers
    fulfill.tracking_company = shipping_company
    fulfill.tracking_urls = tracking_links
    fulfill.prefix_options = { :order_id => order_id }
    fulfill.save
    fulfill.id.present ? fulfill.id : ''

  rescue Exception => e
    ''
  end

  def products
    ShopifyAPI::Session.temp(@client.uid, @client.access_token) { ShopifyAPI::Product.find(:all) }
  end

  def variant_products
    ShopifyAPI::Session.temp(@client.uid, @client.access_token) { ShopifyAPI::Variant.find(:all) }
  end

  def create_webhook
    session = ShopifyAPI::Session.new(@client.uid, @client.access_token)
    ShopifyAPI::Base.activate_session(session)
    webhook = ShopifyAPI::Webhook.create(:format => "json", :topic => "orders/paid", :address => "#{Yetting.base_url}/shopify_callbacks")
    webhook.save
    if webhook.valid? 
      webhook.id
    else
      # raise "Webhook invalid: #{webhook.errors}"
      ''
    end
  rescue Exception => e
    ''
  end

  def delete_webhook(webhook_id)
    session = ShopifyAPI::Session.new(@client.uid, @client.access_token)
    ShopifyAPI::Base.activate_session(session)
    delete_webhook = ShopifyAPI::Webhook.delete(webhook_id)
    delete_webhook.kind_of?(Net::HTTPSuccess) || delete_webhook.kind_of?(Net::HTTPOK) ? true : false
  rescue Exception => e
    false
  end
end