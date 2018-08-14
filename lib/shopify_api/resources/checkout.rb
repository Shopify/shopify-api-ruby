module ShopifyAPI
  class Checkout < Base
    headers['X-Shopify-Checkout-Version'] = '2017-09-03'
  end
end
