# Breaking change notice for version 16.0.0

## Minimum Ruby Version Requirement

The minimum required Ruby version has been updated from 3.0 to 3.2.

### Why this change?

Ruby 3.0  and 3.1 have reached End of Life (EOL).

### Migration Guide

If you're currently using Ruby 3.0 or 3.1, you'll need to upgrade to Ruby 3.2 or higher before upgrading to shopify-api-ruby v16.0.0.

**Note:** Ruby 3.2+ includes performance improvements and new features. Most applications should not require code changes beyond updating the Ruby version itself.
## Removal of `Session#serialize` and `Session.deserialize` methods

The `Session#serialize` and `Session.deserialize` methods have been removed due to a security vulnerability. The `deserialize` method used `Oj.load` without safe mode, which allows instantiation of arbitrary Ruby objects.

These methods were originally created for session persistence when the library handled session storage. After session storage was deprecated in v12.3.0, applications became responsible for their own session persistence, making these methods unnecessary for their original purpose.

### Why this change?

**No impact on most applications:** The `shopify_app gem` stores individual session attributes in database columns and reconstructs sessions using `Session.new()`, which is the recommended pattern.

## Migration Guide

If your application was using `Session#serialize` and `Session.deserialize` for session persistence, you'll need to refactor to store individual session attributes and reconstruct sessions using `Session.new()`.

### Previous implementation (removed in v16.0.0)

```ruby
# Storing a session
session = ShopifyAPI::Auth::Session.new(
  shop: "example.myshopify.com",
  access_token: "shpat_xxxxx",
  scope: "read_products,write_orders"
)

serialized_data = session.serialize
# Store serialized_data in Redis, database, etc.
redis.set("session:#{session.id}", serialized_data)

# Retrieving a session
serialized_data = redis.get("session:#{session_id}")
session = ShopifyAPI::Auth::Session.deserialize(serialized_data)
```

### New implementation (required in v16.0.0)

Store individual session attributes and reconstruct using `Session.new()`:

## Reference: shopify_app gem implementation

The [shopify_app gem](https://github.com/Shopify/shopify_app) provides a reference implementation of session storage that follows these best practices:

**Shop Session Storage** ([source](https://github.com/Shopify/shopify_app/blob/main/lib/shopify_app/session/shop_session_storage.rb)):
```ruby
# Stores attributes in database columns
def store(auth_session)
  shop = find_or_initialize_by(shopify_domain: auth_session.shop)
  shop.shopify_token = auth_session.access_token
  shop.save!
end

# Reconstructs using Session.new()
def retrieve(id)
  shop = find_by(id: id)
  return unless shop

  ShopifyAPI::Auth::Session.new(
    shop: shop.shopify_domain,
    access_token: shop.shopify_token
  )
end
```
