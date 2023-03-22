# Shopify API Library for Ruby

<!-- ![Build Status]() -->
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Build Status](https://github.com/Shopify/shopify-api-ruby/workflows/CI/badge.svg?branch=main)

This library provides support for Ruby [Shopify apps](https://apps.shopify.com/) to access the [Shopify Admin API](https://shopify.dev/docs/api/admin), by making it easier to perform the following actions:

- Creating [online](https://shopify.dev/docs/apps/auth/oauth/access-modes#online-access) or [offline](https://shopify.dev/docs/apps/auth/oauth/access-modes#offline-access) access tokens for the Admin API via OAuth
- Making requests to the [REST API](https://shopify.dev/docs/api/admin-rest)
- Making requests to the [GraphQL API](https://shopify.dev/docs/api/admin-graphql)
- Registering/processing webhooks

In addition to the Admin API, this library also allows querying the [Storefront API](https://shopify.dev/docs/api/storefront).

You can use this library in any application that has a Ruby backend, since it doesn't rely on any specific framework — you can include it alongside your preferred stack and use the features that you need to build your app.

**Note**: These instructions apply to v10 or later of this package. If you're running v9 in your app, you can find the documentation [in this branch](https://github.com/Shopify/shopify-api-ruby/tree/v9).

## Requirements

To follow these usage guides, you will need to:

- have a working knowledge of ruby and a web framework such as Rails or Sinatra
- have a Shopify Partner account and development store
- have an app already set up in your test store or partner account
- add the URL and the appropriate redirect for your OAuth callback route to your app settings

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
  host: "<https://application-host-name.com>",
  scope: "read_orders,read_products,etc",
  session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # See more details below
  is_embedded: true, # Set to true if you are building an embedded app
  api_version: "2022-01", # The version of the API you would like to use
  is_private: false, # Set to true if you have an existing private app
)
```

### Setup a Session Store

In order for the Shopify API gem to properly store sessions it needs an implementation of `ShopifyAPI::Auth::SessionStorage`. We provide one implementation in the gem, `ShopifyAPI::Auth::FileSessionStorage`, which is suitable for testing/development, but isn't intended for production apps. See the [Session Storage doc](docs/usage/session_storage.md) for instructions on how to create a custom session store for a production application.

Session information would is typically stored in cookies on the browser. However, due to restrictions with modern browsers we highly discourage using cookies for embedded apps. For this reason, an app needs to define a storage implementation that the library can use to store and retrieve a session given its ID. In a non-embedded app this ID will come from a cookie, whereas in an embedded app this ID will come from [App Bridge](https://shopify.dev/docs/apps/tools/app-bridge).

### Performing OAuth

You need to go through OAuth as described [here](https://shopify.dev/docs/apps/auth/oauth) to create sessions for shops using your app.
The Shopify API gem tries to make this easy by providing functions to begin and complete the OAuth process. See the [Oauth doc](docs/usage/oauth.md) for instructions on how to use these.

### Register Webhooks and a Webhook Handler

If you intend to use webhooks in your application follow the steps in the [Webhooks doc](docs/usage/webhooks.md) for instructions on registering and handling webhooks.

### Start Making Authenticated Shopify Requests

Once your app can perform OAuth, it can now make authenticated Shopify API calls using the Admin [REST](docs/usage/rest.md) or [GraphQL](docs/usage/graphql.md) Clients, or the [Storefront API GraphQL Client](docs/usage/graphql_storefront.md).

## Breaking Change Notices

### Breaking change notice for version 10.0.0

We've rewritten this library for v10, so that it provides all essential features for a Shopify app without depending on the [Active Resource](https://github.com/rails/activeresource) or [graphql-client](https://github.com/github/graphql-client) libraries.

Here are the main features it provides:

- OAuth support, both with online and offline tokens.
- Full, transparent support for JWT sessions for embedded apps and cookies for non-embedded ones.
  - Removal of support for 3rd party cookies which are increasingly more difficult to use with modern browsers.
- Admin API support
  - Auto-generated, version-specific REST resources which are similar to `ActiveResource` (though not identical), that provide methods for all endpoints defined in our [REST API reference](https://shopify.dev/docs/api/admin-rest), as well as direct definition of known attributes.
  - A GraphQL client that doesn't rely on the ActiveResource implementation for REST.
- Webhook management, with features for adding handlers and registering them with Shopify.
- Storefront GraphQL API support

Please refer to [the documentation](docs/getting_started.md) in this repository for instructions on how to use each of these components.

With this, a lot changed in how apps access the library. Here are the updates you should make when migrating to v10:

- Call `ShopifyAPI::Context.setup` when setting up your app. This class holds global configurations for your app and defines how the library behaves.
- If not using the `shopify_app` gem, your app needs to provide an implementation of `ShopifyAPI::Auth::SessionStorage` for production. Read more about this [in our documentation](docs/usage/session_storage.md).
- To change the `User-Agent` header, use `user_agent_prefix` in `ShopifyAPI::Context.setup`.
- Usages of the `ActiveResource` classes for REST API requests need to be refactored into the new format. You can find detailed examples on how each of the endpoints work in our [reference documentation](https://shopify.dev/docs/api/admin-rest).

    Please see below a (non-exhaustive) list of common replacements to guide you in your updates, using the `Order` resource as an example.

    | Before                                             | After |
    | ---                                                | --- |
    | `Order.find(:all, params: {param1: value1})`       | `Order.all(param1: value1)` |
    | `Order.find(<id>)`                                 | `Order.find(id: <id>)` |
    | `order = Order.new(<id>)`<br/>`order.post(:close)` | `order = Order.new`<br/>`order.close` |
    | `order = Order.new(<id>)`<br/>`order.delete`       | `Order.delete(id: <id>)` |

## Breaking changes for older versions

See [BREAKING_CHANGES_FOR_OLDER_VERSIONS](BREAKING_CHANGES_FOR_OLDER_VERSIONS.md)

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
