# Breaking change notice for version 10.0.0

We've rewritten this library for v10, so that it provides all essential features for a Shopify app without depending on the [Active Resource](https://github.com/rails/activeresource) or [graphql-client](https://github.com/github/graphql-client) libraries.

## New Features
Here are the main features version 10 provides:

- OAuth support, both with online and offline tokens.
- Full, transparent support for JWT sessions for embedded apps and cookies for non-embedded ones.
  - Removal of support for 3rd party cookies which are increasingly more difficult to use with modern browsers.
- Admin API support
  - Auto-generated, version-specific REST resources which are similar to `ActiveResource` (though not identical), that provide methods for all endpoints defined in our [REST API reference](https://shopify.dev/docs/api/admin-rest), as well as direct definition of known attributes.
  - A GraphQL client that doesn't rely on the ActiveResource implementation for REST.
- Webhook management, with features for adding handlers and registering them with Shopify.
- Storefront GraphQL API support

Please refer to the [Getting Started](docs/getting_started.md) guide in this repository for instructions on how to use each of these components.

## Upgrade Guide
With this, a lot changed in how apps access the library. Here are the updates you should make when migrating to v10:

### 1. Configuration Changes
#### Removed ShopifyAPI::Base
`ShopifyAPI::Base` class has been removed. Previous versions of this gem used this class to configure API request setting like:
  - API request version
    - Previously: Set by `ShopifyAPI::Base.api_version = "xxxx"`
    - Change: This is now configured in `api_version` of [ShopifyAPI::Context.setup](#shopifyapicontext-setup)
  - Set `User-Agent` on API request header
    - Previously: Set by `ShopifyAPI::Base.header["User-Agent"] = "xxxxx"`
    - Change: This is now configured in `user_agent_prefix` of [ShopifyAPI::Context.setup](#shopifyapicontext-setup)
  - Set custom headers on API requests
    - Previously: Set by `ShopifyAPI::Base.header["User-Agent"] = "xxxxx"`
    - Change: Custom headers can be added to requests when you use [`ShopifyAPI::Clients::HttpRequest`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/clients/http_request.rb#L14)


#### ShopifyAPI::Context.setup
Initializing the `ShopifyAPI::Context` with the parameters of your app by calling `ShopifyAPI::Context.setup` (example below) when your app starts (e.g `application.rb` in a Rails app).

```ruby
ShopifyAPI::Context.setup(
  api_key: "<api-key>",
  api_secret_key: "<api-secret-key>",
  host_name: "<application-host-name>",
  scope: "read_orders,read_products,etc",
  is_embedded: true, # Set to true if you are building an embedded app
  is_private: false, # Set to true if you are building a private app
  api_version: "2021-01" # The version of the API you would like to use
  user_agent_prefix: "<user_agent_prefix>" # Set a custom prefix for "User-Agent" header when making API requests
  ###
)
```

See other fields accepted during `ShopifyAPI::Context` setup in [context.rb](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/context.rb).

### Session Respository Changes

### Client Changes
#### GraphQL
#### REST

- Call `ShopifyAPI::Context.setup` when setting up your app. This class holds global configurations for your app and defines how the library behaves.
Session persistence is handled by the [ShopifyApp](https://github.com/Shopify/shopify_app) gem and is recommended for use in the Rails context. See that gem's [documentation on how to use it](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md).
- To change the `User-Agent` header, use `user_agent_prefix` in `ShopifyAPI::Context.setup`.
- Usages of the `ActiveResource` classes for REST API requests need to be refactored into the new format. You can find detailed examples on how each of the endpoints work in our [reference documentation](https://shopify.dev/docs/api/admin-rest).

    Please see below a (non-exhaustive) list of common replacements to guide you in your updates, using the `Order` resource as an example.

    | Before                                             | After |
    | ---                                                | --- |
    | `Order.find(:all, params: {param1: value1})`       | `Order.all(param1: value1)` |
    | `Order.find(<id>)`                                 | `Order.find(id: <id>)` |
    | `order = Order.new(<id>)`<br/>`order.post(:close)` | `order = Order.new`<br/>`order.close` |
    | `order = Order.new(<id>)`<br/>`order.delete`       | `Order.delete(id: <id>)` |


