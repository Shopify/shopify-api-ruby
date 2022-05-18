# Shopify API Library for Ruby

<!-- ![Build Status]() -->
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Build Status](https://github.com/Shopify/shopify_api/workflows/CI/badge.svg?branch=main)

This library provides support for Ruby [Shopify apps](https://apps.shopify.com/) to access the [Shopify Admin API](https://shopify.dev/api/admin), by making it easier to perform the following actions:

- Creating [online](https://shopify.dev/concepts/about-apis/authentication#online-access) or [offline](https://shopify.dev/concepts/about-apis/authentication#offline-access) access tokens for the Admin API via OAuth
- Making requests to the [REST API](https://shopify.dev/api/admin-rest)
- Making requests to the [GraphQL API](https://shopify.dev/api/admin-graphql)
- Registering/processing webhooks

In addition to the Admin API, this library also allows querying the [Storefront API](https://shopify.dev/docs/storefront-api).

You can use this library in any application that has a Ruby backend, since it doesn't rely on any specific framework — you can include it alongside your preferred stack and use the features that you need to build your app.

**Note**: These instructions apply to v10 or later of this package. If you're running v9 in your app, you can find the documentation [in this branch](https://github.com/Shopify/shopify_api/tree/v9).

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
  api_version: "2022-01" # The version of the API you would like to use
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

## Breaking Change Notices

### Breaking change notice for version 10.0.0

We've rewritten this library for v10, so that it provides all essential features for a Shopify app without requiring any other packages.

Here are the main features it provides:

- OAuth support, both with online and offline tokens.
- Full, transparent support for JWT sessions for embedded apps and cookies for non-embedded ones.
  - Removal of support for 3rd party cookies which are increasingly more difficult to use with modern browsers.
- Admin API support
  - Auto-generated, version-specific REST resources which are similar to `ActiveResource` (though not identical), that provide methods for all endpoints defined in our [REST API reference](https://shopify.dev/api/admin-rest), as well as direct definition of known attributes.
  - A GraphQL client that doesn't rely on the ActiveResource implementation for REST.
- Webhook management, with features for adding handlers and registering them with Shopify.
- Storefront GraphQL API support

Please refer to [the documentation](https://github.com/Shopify/shopify_api/blob/main/docs/getting_started.md) in this repository for instructions on how to use each of these components.

With this, a lot changed in how apps access the library. Here are the updates you should make when migrating to v10:

- Call `ShopifyAPI::Context.setup` when setting up your app. This class holds global configurations for your app and defines how the library behaves.
- If not using the `shopify_app` gem, your app needs to provide an implementation of `ShopifyAPI::Auth::SessionStorage` for production. Read more about this [in our documentation](docs/usage/session_storage.md).
- To change the `User-Agent` header, use `user_agent_prefix` in `ShopifyAPI::Context.setup`.
- Usages of the `ActiveResource` classes for REST API requests need to be refactored into the new format. You can find detailed examples on how each of the endpoints work in our [reference documentation](https://shopify.dev/api/admin-rest).

    Please see below a (non-exhaustive) list of common replacements to guide you in your updates, using the `Order` resource as an example.

    | Before | After |
    | --- | --- |
    | `Order.find(:all, params: {param1: value1})` | `Order.all(param1: value1, session:)` |
    | `Order.find(<id>)` | `Order.find(id: <id>, session:)` |
    | `order = Order.new(<id>)`<br/>`order.post(:close)` | `order = Order.new(session:)`<br/>`order.close()` |
    | `order = Order.new(<id>)`<br/>`order.delete` | `Order.delete(id: <id>, session:)` |

### Breaking change notice for version 8.0.0

Version 7.0.0 introduced ApiVersion, and known versions were hardcoded into the gem. Manually defining API versions is no longer required for versions not listed in the gem. Version 8.0.0 removes the following:
* `ShopifyAPI::ApiVersion::Unstable`
* `ShopifyAPI::ApiVersion::Release`
* `ShopifyAPI::ApiVersion.define_version`

The following methods on `ApiVersion` have been deprecated:
- `.coerce_to_version` deprecated. use `.find_version`
- `.define_known_versions` deprecated. Use `.fetch_known_versions`
- `.clear_defined_versions` deprecated. Use. `.clear_known_versions`
- `.latest_stable_version` deprecated. Use `ShopifyAPI::Meta.admin_versions.find(&:latest_supported)` (this fetches info from Shopify servers. No authentication required.)
- `#name` deprecated. Use `#handle`
- `#stable?` deprecated. Use `#supported?`

Version 8.0.0 introduces a _version lookup mode_. By default, `ShopifyAPI::ApiVersion.version_lookup_mode` is `:define_on_unknown`. When setting the api_version on `Session` or `Base`, the `api_version` attribute takes a version handle (i.e. `'2019-07'` or `:unstable`) and sets an instance of `ShopifyAPI::ApiVersion` matching the handle. When the version_lookup_mode is set to `:define_on_unknown`, any handle will naïvely create a new `ApiVersion` if the version is not in the known versions returned by `ShopifyAPI::ApiVersion.versions`.

To ensure you're setting only known and active versions, call :

```ruby
ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown
ShopifyAPI::ApiVersion.fetch_known_versions
```

Known and active versions are fetched from https://app.shopify.com/services/apis.json and cached. Trying to use a version outside this cached set will raise an error. To switch back to naïve lookup and create a version if one is not found, call `ShopifyAPI::ApiVersion.version_lookup_mode = :define_on_unknown`.

### Breaking change notice for version 7.0.0

#### Changes to ShopifyAPI::Session
When creating sessions, `api_version`is now required and uses keyword arguments.

To upgrade your use of ShopifyAPI you will need to make the following changes.

```ruby
ShopifyAPI::Session.new(domain, token, extras)
```
is now
```ruby
ShopifyAPI::Session.new(domain: domain, token: token, api_version: api_version, extras: extras)
```
Note `extras` is still optional. The other arguments are required.

```ruby
ShopifyAPI::Session.temp(domain, token, extras) do
  ...
end
```
is now
```ruby
ShopifyAPI::Session.temp(domain: domain, token: token, api_version: api_version) do
  ...
end
```

For example, if you want to use the `2019-04` version, you will create a session like this:
```ruby
session = ShopifyAPI::Session.new(domain: domain, token: token, api_version: '2019-04')
```
if you want to use the `unstable` version, you will create a session like this:
```ruby
session = ShopifyAPI::Session.new(domain: domain, token: token, api_version: :unstable)
```

#### Changes to how to define resources

If you have defined or customized Resources, classes that extend `ShopifyAPI::Base`:
The use of `self.prefix =` has been deprecated; you should now use `self.resource =` and not include `/admin`.
For example, if you specified a prefix like this before:
```ruby
class MyResource < ShopifyAPI::Base
  self.prefix = '/admin/shop/'
end
```
You will update this to:
```ruby
class MyResource < ShopifyAPI::Base
  self.resource_prefix = 'shop/'
end
```

#### URL construction

If you have specified any full paths for API calls in find
```ruby
def self.current(options={})
  find(:one, options.merge(from: "/admin/shop.#{format.extension}"))
end
```
would be changed to

```ruby
def self.current(options = {})
  find(:one, options.merge(
    from: api_version.construct_api_path("shop.#{format.extension}")
  ))
end
```

#### URLs that have not changed

- OAuth URLs for `authorize`, getting the `access_token` from a code, `access_scopes`, and using a `refresh_token` have _not_ changed.
  - get: `/admin/oauth/authorize`
  - post: `/admin/oauth/access_token`
  - get: `/admin/oauth/access_scopes`
- URLs for the merchant’s web admin have _not_ changed. For example: to send the merchant to the product page the url is still `/admin/product/<id>`


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
