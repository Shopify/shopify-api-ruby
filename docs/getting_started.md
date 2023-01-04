# Getting started

This page will outline everything you need to know and the steps you need to follow in order to start using the Shopify Ruby API gem in your app.

## Requirements

- A working knowledge of ruby and a web framework such as Rails or Sinatra
- A custom app already set up in your test store or partner account
- We recommend `ngrok` to tunnel traffic to your localhost for testing

## Installation

Add the following to your Gemfile:

`gem "shopify_api"`

## Steps to use the Gem

### Setup Shopify Context

Start by initializing the `ShopifyAPI::Context` with the parameters of your app by calling `ShopifyAPI::Context.setup` (example below) when your app starts (e.g `application.rb` in a Rails app).

```ruby
ShopifyAPI::Context.setup(
  api_key: "<api-key>",
  api_secret_key: "<api-secret-key>",
  host_name: "<application-host-name>",
  scope: "read_orders,read_products,etc",
  session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # This is only to be used for testing, more information in session docs
  is_embedded: true, # Set to true if you are building an embedded app
  is_private: false, # Set to true if you are building a private app
  api_version: "2021-01" # The vesion of the API you would like to use
)
```

### Setup a Session Store

In order for the Shopify API gem to properly store sessions it needs an implementation of `ShopifyAPI::Auth::SessionStorage`. There is one provided in the gem, `ShopifyAPI::Auth::FileSessionStorage`, this is suitable for testing, however it is not intended for production apps. See the [Session Storage doc](usage/session_storage.md) for instructions on how to create a custom session store for a production application.

Normally session information would be stored in cookies on the browser. However, due to restrictions with modern browsers we highly discourage using cookies for embedded apps. For this reason, an app needs to define a storage implementation that can be used to store and retrieve a session given an ID. In a non embedded app this ID will come from a cookie however, in an embedded app this ID will come from [App Bridge](https://shopify.dev/apps/tools/app-bridge)

### Performing OAuth

Next, unless you are making a private app, you need to go through OAuth as described [here](https://shopify.dev/apps/auth/oauth) to create sessions for shops using your app.
The Shopify API gem tries to make this easy by providing functions to begin and complete the OAuth process. See the [Oauth doc](usage/oauth.md) for instructions on how to use these.

### Register Webhooks and a Webhook Handler

If you intend to use webhooks in your application follow the steps in the [Webhooks doc](usage/webhooks.md) for instructions on registering and handling webhooks.

### Start Making Authenticated Shopify Requests

You can now start making authenticated Shopify API calls using the Admin [REST](usage/rest.md) or [GraphQL](usage/graphql.md) Clients or the [Storefront GraphQL Client](usage/graphql_storefront.md).
