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
  - **API request version**
    - **Previously**: Set by `ShopifyAPI::Base.api_version = "xxxx"`
    - **Change**: Configured `api_version` in [ShopifyAPI::Context.setup](#shopifyapicontextsetup)
  - **Set `User-Agent` on API request header**
    - **Previously**: Set by `ShopifyAPI::Base.header["User-Agent"] = "xxxxx"`
    - **Change**: Configured `user_agent_prefix` in [ShopifyAPI::Context.setup](#shopifyapicontextsetup)
  - **Set custom headers on API requests**
    - **Previously**: Set by `ShopifyAPI::Base.header["User-Agent"] = "xxxxx"`
    - **Change**: Custom headers can be added to requests when you use [`ShopifyAPI::Clients::HttpRequest`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/clients/http_request.rb#L14)

#### ShopifyAPI::Context.setup
Initializing the `ShopifyAPI::Context` with the parameters of your app by calling `ShopifyAPI::Context.setup` (example below) when your app starts (e.g `application.rb` in a Rails app).
This class holds global configurations for your app and defines how the library behaves.

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

### 2. Session Changes
`ShopifyAPI::Base` class has been removed, you can no longer activate session using `ShopifyAPI::Base.activate_session`. Instead, you can use
`ShopifyAPI::Context.activate_session` to set the active session ([`ShopifyAPI::Auth::Session`](#shopifyapiauthsesion)).
If you're using the [ShopifyApp](https://github.com/Shopify/shopify_app) gem in a Rails app, you don't have to manually set the active session if you use the included `ActiveSupport` concerns. See [Sesssion Docs](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md) from ShopifyApp gem.

You can also manually specify the session to use without setting the active session by passing in the session object ([`ShopifyAPI::Auth::Session`](#shopifyapiauthsesion)) when instantiating new `ShopifyAPI::Clients` objects.
If session is `nil`, it'll default to use active session from `ShopifyAPI::Context.active_session`.

```ruby
# Manually specifying a session (ShopifyAPI::Auth::Session) in API clients.

# GraphQL Client
graphql_client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)

# REST Client
rest_client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

# Using REST Resources
rest_resource = ShopifyAPI::Shop.new(session: session)
```

##### ShopifyAPI::Auth::Session
If you're building a Rails app, it is highly recommended for you to use the [`ShopifyApp` gem to perform OAuth and session storage](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md).

If you're not using Rails, please see the [Performing OAuth](./docs/usage/oauth.md) guide on how to perform OAuth to retrieve and store sessions.

### 3. API Client Changes

#### GraphQL
#### REST

##### Using REST Resources
- The use of `ActiveResource` has been deprecated, REST API requests must now be refactored to use the new format that better represents our REST API schema.
- Previously the api_version is specified in `ShopifyAPI::Base.api_version`, that's been deprecated. It's now configured in [`ShopifyAPI::Context.setup`](#shopifyapicontextsetup).

###### Example refactor
⚠️ You can find detailed examples on how each of the resource endpoints work in our [REST reference documentation](https://shopify.dev/docs/api/admin-rest).

Please see below a (non-exhaustive) list of common replacements to guide you in your updates, using the `Order` resource as an example.
For more detail, see [`order` reference documentation's](https://shopify.dev/docs/api/admin-rest/2023-07/resources/order#top) ruby example.

|Usage | Before| After |
| -----| --- | --- |
|Find partially paid orders| `Order.find(:all, params: {financial_status: "partially_paid"})`| `Order.all(financial_status: "partially_paid")` |
|Find order by ID `<id>` | `Order.find(<id>)` | `Order.find(id: <id>)` |
|Update an order's fulfillment status|`order = Order.find<id>`<br/>`order.fulfillment_status = "fulfilled"`<br/>`order.note = "Fulfilled on September 6, 2023"`<br/>`order.save`|`order = Order.find(id: <id>)`<br/>`order.fulfillment_status = "fulfilled"`<br/>`order.note = "Fulfilled on September 6, 2023"`<br/>`order.save!`|
|Close an order| `order = Order.new(<id>)`<br/>`order.post(:close)` | `order = Order.find(id: <id>)`<br/>`order.close` |
|Delete an order| `order = Order.new(<id>)`<br/>`order.delete`       | `Order.delete(id: <id>)` |

##### Using REST Admin Client
If you do not want to use the REST resource classes, you can use our REST Admin client directly to make HTTP requests.

⚠️ See other usages in [`REST` client documentation](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/rest.md).

Example:
```ruby
# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

# Update title for product with ID <id>
body = {
  product: {
    title: "My cool product"
  }
}

# Use `client.put` to send your request to the specified Shopify Admin REST API endpoint.
client.put(path: "products/<id>.json", body: body)
```

