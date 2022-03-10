# Shopify API Library for Ruby

<!-- ![Build Status]() -->
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Build Status](https://github.com/Shopify/shopify_api/workflows/CI/badge.svg?branch=main)

## A Note About Versions

The latest release of `shopify_api` is v9. The main branch of this repo reflects the upcoming v10 release, which has some major changes. If you’re looking for the documentation / instructions for v9, you can find them [in this branch](https://github.com/Shopify/shopify_api/tree/v9).

## v10

This library provides support for Ruby [Shopify apps](https://apps.shopify.com/) to access the [Shopify Admin API](https://shopify.dev/api/admin), by making it easier to perform the following actions:

- Creating [online](https://shopify.dev/concepts/about-apis/authentication#online-access) or [offline](https://shopify.dev/concepts/about-apis/authentication#offline-access) access tokens for the Admin API via OAuth
- Making requests to the [REST API](https://shopify.dev/api/admin-rest)
- Making requests to the [GraphQL API](https://shopify.dev/api/admin-graphql)
- Registering/processing webhooks

In addition to the Admin API, this library also allows querying the [Storefront API](https://shopify.dev/docs/storefront-api).

You can use this library in any application that has a Ruby backend, since it doesn't rely on any specific framework — you can include it alongside your preferred stack and use the features that you need to build your app.

## Requirements

To follow these usage guides, you will need to:

- have a working knowledge of ruby and a web framework such as Rails or Sinatra
- have a Shopify Partner account and development store
- _OR_ have a test store where you can create a private app
- have an app already set up in your test store or partner account
- use [ngrok](https://ngrok.com/download) to create a secure tunnel to your app running on your localhost
- add the `ngrok` URL and the appropriate redirect for your OAuth callback route to your app settings

## Installation

Add the following to your Gemfile:

```sh
gem "shopify_api"
```

or use [bundler](https://bundler.io):

```sh
bundle add shopify_api
```

## Steps to use the Gem

### Setup Shopify Context

Start by initializing the `ShopifyAPI::Context` with the parameters of your app by calling `ShopifyAPI::Context.setup` (example below) when your app starts (e.g `application.rb` in a Rails app).

```ruby
ShopifyAPI::Context.setup(
  api_key: "<api-key>",
  api_secret_key: "<api-secret-key>",
  host_name: "<application-host-name>",
  scope: "read_orders,read_products,etc",
  session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # See more details below
  is_embedded: true, # Set to true if you are building an embedded app
  is_private: false, # Set to true if you are building a private app
  api_version: "2022-01" # The vesion of the API you would like to use
)
```

### Setup a Session Store

In order for the Shopify API gem to properly store sessions it needs an implementation of `ShopifyAPI::Auth::SessionStorage`. We provide one implementation in the gem, `ShopifyAPI::Auth::FileSessionStorage`, which is suitable for testing/development, but isn't intended for production apps. See the [Session Storage doc](docs/usage/session_storage.md) for instructions on how to create a custom session store for a production application.

Session information would is typically stored in cookies on the browser. However, due to restrictions with modern browsers we highly discourage using cookies for embedded apps. For this reason, an app needs to define a storage implementation that the library can use to store and retrieve a session given its ID. In a non-embedded app this ID will come from a cookie, whereas in an embedded app this ID will come from [App Bridge](https://shopify.dev/apps/tools/app-bridge).

### Performing OAuth

Next, unless you are making a private app, you need to go through OAuth as described [here](https://shopify.dev/apps/auth/oauth) to create sessions for shops using your app.
The Shopify API gem tries to make this easy by providing functions to begin and complete the OAuth process. See the [Oauth doc](docs/usage/oauth.md) for instructions on how to use these.

### Register Webhooks and a Webhook Handler

If you intend to use webhooks in your application follow the steps in the [Webhooks doc](docs/usage/webhooks.md) for instructions on registering and handling webhooks.

### Start Making Authenticated Shopify Requests

Once your app can perform OAuth, it can now make authenticated Shopify API calls using the Admin [REST](docs/usage/rest.md) or [GraphQL](docs/usage/graphql.md) Clients, or the [Storefront API GraphQL Client](docs/usage/graphql_storefront.md).

## Developing this gem

After cloning the repository, you can install the dependencies with bundler:

```bash
bundle install
```

To run the automated tests:

```bash
bundle exec rake test
```

We use [rubocop](https://rubocop.org) to lint/format the code. You can run it with the following command:

```bash
bundle exec rubocop
```
