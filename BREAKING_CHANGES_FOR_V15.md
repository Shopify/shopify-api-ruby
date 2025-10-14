# Breaking change notice for version 15.0.0

## Removal of positional `storefront_access_token` parameter from Storefront GraphQL Client

The `ShopifyAPI::Clients::Graphql::Storefront` class no longer accepts the public Storefront access token as a positional parameter. You must now use the named parameters `private_token:` or `public_token:` instead.

This parameter was deprecated in [PR #1302](https://github.com/Shopify/shopify-api-ruby/pull/1302) (v14.1.0).

### Previous implementation (deprecated in v14.1.0)

```ruby
# Old way: passing token as positional parameter
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, storefront_access_token)

# With API version
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, storefront_access_token, api_version: "2024-01")
```

### New implementation (required in v15.0.0)

```ruby
# Use private token (recommended)
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, private_token: storefront_private_access_token)

# Or use public token
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, public_token: storefront_public_access_token)

# With API version
client = ShopifyAPI::Clients::Graphql::Storefront.new(
  shop_url,
  private_token: storefront_private_access_token,
  api_version: "2024-01"
)
```

For more information on private vs public Storefront access tokens, see [Shopify's authentication documentation](https://shopify.dev/docs/api/usage/authentication#getting-started-with-private-access).

## Removal of `ShopifyAPI::Webhooks::Handler`

The `ShopifyAPI::Webhooks::Handler` class has been removed in favor of `ShopifyAPI::Webhooks::WebhookHandler`. The `ShopifyAPI::Webhooks::WebhookHandler` class is now the recommended way to handle webhooks.

Make a module or class that includes or extends `ShopifyAPI::Webhooks::WebhookHandler` and implement the `handle` method which accepts the following named parameters: data: `WebhookMetadata`.

In v14, adding new fields to the callback would become a breaking change. To make this code more flexible, handlers will now receive an object that can be typed and extended.

`data` will have the following keys:

- `topic`, `String` - The topic of the webhook
- `shop`, `String` - The shop domain of the webhook
- `body`, `T::Hash[String, T.untyped]`- The body of the webhook
- `webhook_id`, `String` - The id of the webhook event to [avoid duplicates](https://shopify.dev/docs/apps/webhooks/best-practices#ignore-duplicates)
- `api_version`, `String` - The api version of the webhook

### New implementation
```ruby
module WebhookHandler
  extend ShopifyAPI::Webhooks::WebhookHandler

  class << self
    def handle_webhook(data:)
      puts "Received webhook! topic: #{data.topic} shop: #{data.shop} body: #{data.body} webhook_id: #{data.webhook_id} api_version: #{data.api_version"
    end
  end
end
```

### Previous implementation
```ruby
module WebhookHandler
  include ShopifyAPI::Webhooks::Handler

  class << self
    def handle(topic:, shop:, body:)
      puts "Received webhook! topic: #{topic} shop: #{shop} body: #{body}"
    end
  end
end
```
