# Breaking change notice for version 15.0.0

## Removal of `LATEST_SUPPORTED_ADMIN_VERSION` and `RELEASE_CANDIDATE_ADMIN_VERSION` constants

The `LATEST_SUPPORTED_ADMIN_VERSION` and `RELEASE_CANDIDATE_ADMIN_VERSION` constants have been removed to prevent semantic versioning (semver) breaking changes. Previously, these constants would automatically update every quarter when new API versions were released, causing unintended breaking changes for apps.

### Migration Guide

**If you were using these constants directly:**

```ruby
# Before (v14 and earlier)
api_version = ShopifyAPI::LATEST_SUPPORTED_ADMIN_VERSION
# or
api_version = ShopifyAPI::RELEASE_CANDIDATE_ADMIN_VERSION

# After (v15+)
api_version = "2025-07" # Explicitly specify the version you want to use
```

**In your Context.setup:**

The `api_version` parameter has always been required in `Context.setup`, so most apps should not be affected. However, you must now explicitly specify which API version you want to use:

```ruby
# Before (v14 and earlier)
ShopifyAPI::Context.setup(
  api_key: "<api-key>",
  api_secret_key: "<api-secret-key>",
  host: "<https://application-host-name.com>",
  scope: "read_orders,read_products,etc",
  is_embedded: true,
  api_version: ShopifyAPI::LATEST_SUPPORTED_ADMIN_VERSION, # This constant no longer exists
  is_private: false,
)

# After (v15+)
ShopifyAPI::Context.setup(
  api_key: "<api-key>",
  api_secret_key: "<api-secret-key>",
  host: "<https://application-host-name.com>",
  scope: "read_orders,read_products,etc",
  is_embedded: true,
  api_version: "2025-07", # Explicitly specify the version
  is_private: false,
)
```

**Finding the right API version:**

You can see all supported API versions by referencing:
```ruby
ShopifyAPI::SUPPORTED_ADMIN_VERSIONS
# => ["unstable", "2025-10", "2025-07", "2025-04", ...]
```

**Why this change?**
 By requiring explicit version specification, apps can:
- Control when they upgrade to new API versions
- Test thoroughly before upgrading
- Avoid unexpected breaking changes from automatic version updates

## Removal of `ShopifyAPI::Webhooks::Handler`

The `ShopifyAPI::Webhooks::Handler` class has been removed in favor of `ShopifyAPI::Webhooks::WebhookHandler`. The `ShopifyAPI::Webhooks::WebhookHandler` class is now the recommended way to handle webhooks.

Make a module or class that includes or extends `ShopifyAPI::Webhooks::WebhookHandler` and implement the `handle` method which accepts the following named parameters: data: `WebhookMetadata`.

In v14, adding new fields to the callback would become a breaking change. To make this code more flexible, handlers will now receive an object that can be typed and extended.

`data` will have the following keys
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
    def handle(data:)
      puts "Received webhook! topic: #{data.topic} shop: #{data.shop} body: #{data.body} webhook_id: #{data.webhook_id} api_version: #{data.api_version}"
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
