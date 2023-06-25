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
  is_embedded: true, # Set to true if you are building an embedded app
  is_private: false, # Set to true if you are building a private app
  api_version: "2021-01" # The version of the API you would like to use
)
```

### Performing OAuth

Next, unless you are making a private app, you need to go through OAuth as described [here](https://shopify.dev/docs/apps/auth/oauth) to create sessions for shops using your app.
The Shopify API gem tries to make this easy by providing functions to begin and complete the OAuth process. See the [Oauth doc](usage/oauth.md) for instructions on how to use these.

### Register Webhooks and a Webhook Handler

If you intend to use webhooks in your application follow the steps in the [Webhooks doc](usage/webhooks.md) for instructions on registering and handling webhooks.

### Start Making Authenticated Shopify Requests

You can now start making authenticated Shopify API calls using the Admin [REST](usage/rest.md) or [GraphQL](usage/graphql.md) Clients or the [Storefront GraphQL Client](usage/graphql_storefront.md).
