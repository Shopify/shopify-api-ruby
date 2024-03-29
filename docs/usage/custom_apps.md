# Custom Apps

If you have followed instructions on creating [custom apps](https://help.shopify.com/current/manual/apps/app-types/custom-apps), you should be able to access your API token without having to go through the OAuth flow.

You can follow instructions for [initializing the session object](#initializing-the-session-object) to construct the session object to be used in authenticated API calls to your store.  There are 2 methods to use the session object to make API calls:
1. [Passing `session` object into each client request](#passing-session-object-into-each-client-request)
2. [Setting `active_session` in `ShopifyAPI::Context`](#setting-active-session-in-shopifyapicontext)

## Initializing the Session object
Following is a basic example to construct a simple Session object. You can see full list of parameters for this object in the [class definition](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/session.rb)
```ruby
session = ShopifyAPI::Auth::Session.new(
  shop: "#{your_shop_name}.myshopify.com",
  access_token: "the_token_for_your_custom_app_found_in_admin"
)

```
## Using `Session` to make API calls

### Passing `session` object into each client request
Example:
```ruby
def make_api_request(shop)
  # 1. create session object
    session = ShopifyAPI::Auth::Session.new(
      shop: "#{your_shop_name}.myshopify.com",
      access_token: "the_token_for_your_custom_app_found_in_admin"
    )

  # 2a. Create API client with the session information
  # session must be type `ShopifyAPI::Auth::Session`
  graphql_client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)
  response = graphql_client.query(query: MY_API_QUERY)

  # 2b. REST example
  product_count = ShopifyAPI::Product.count(session: session)

  ...
end
```

### Setting `active_session` in `ShopifyAPI::Context`
Alternatively, if you don't want to keep having to create/retrieve a Session object for a shop, you may set [`ShopifyAPI::Context.active_session`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/context.rb#L144).
All of the API client classes will [use the `active_session`](https://github.com/Shopify/shopify-api-ruby/blob/c3bb9d8f8b6053756149a4cf9299e059ec337544/lib/shopify_api/clients/http_client.rb#L13) if the `session` passed in is `nil`.

Example:
```ruby
#### Configuration
def configure_app
  # This method is called before making authenticated API calls
  session = ShopifyAPI::Auth::Session.new(
      shop: "#{your_shop_name}.myshopify.com",
      access_token: "the_token_for_your_custom_app_found_in_admin"
    )

  # Activate session to be used in all API calls
  # session must be type `ShopifyAPI::Auth::Session`
  ShopifyAPI::Context.activate_session(session)
end

#### Using clients to make authenticated API calls
def make_api_request
  # 1. Create API client without session information
  # The graphql_client will use `ShopifyAPI::Context.active_session` when making API calls
  graphql_client = ShopifyAPI::Clients::Graphql::Admin.new

  # 2. Use API client to make queries
  ...
end

```

⚠️ See following docs on how to use the API clients:
- [Make a GraphQL API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/graphql.md)
- [Make a REST API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/rest.md)
