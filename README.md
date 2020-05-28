Shopify API
===========
[![Version][gem]][gem_url] [![Build Status](https://travis-ci.org/Shopify/shopify_api.svg?branch=master)](https://travis-ci.org/Shopify/shopify_api)

[gem]: https://img.shields.io/gem/v/shopify_api.svg
[gem_url]: https://rubygems.org/gems/shopify_api

The Shopify API gem allows Ruby developers to access the admin section of Shopify stores programmatically.

The best way to consume the Shopify API is through GraphQL, which enables high volume mutations, bulk operations, and access to all new features.

The REST API is implemented as JSON over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has a distinct URL and is manipulated in isolation. In other words, we’ve tried to make the API follow the REST principles as much as possible.

- [Shopify API](#shopify-api)
- [Usage](#usage)
  * [Requirements](#requirements)
    + [Ruby version](#ruby-version)
  * [Installation](#installation)
  * [Getting Started](#getting-started)
    + [1) Create an app](#1-create-an-app)
    + [2A) Private Apps](#2a-private-apps)
    + [2B) Public and Custom Apps](#2b-public-and-custom-apps)
    + [3) Requesting access from a shop](#3-requesting-access-from-a-shop)
    + [4) Trading your `code` for an access token.](#4-trading-your--code--for-an-access-token)
    + [5) Activating the session](#5-activating-the-session)
    + [6A) Making requests to the GraphQL API](#6a-making-requests-to-the-graphql-api)
    + [6B) Making requests to the REST API](#6b-making-requests-to-the-rest-api)
  * [Console](#console)
  * [Thread safety](#thread-safety)
  * [Bulk Operations](#bulk-operations)
    + [Example](#example)
      - [1) Start the bulk operation](#1-start-the-bulk-operation)
      - [2) Poll the status of the bulk operation](#2-poll-the-status-of-the-bulk-operation)
      - [3) Retrieve your data](#3-retrieve-your-data)
  * [Pagination](#pagination)
- [Breaking Change Notices](#breaking-change-notices)
  * [Breaking change notice for version 8.0.0](#breaking-change-notice-for-version-800)
  * [Breaking change notice for version 7.0.0](#breaking-change-notice-for-version-700)
    + [Changes to ShopifyAPI::Session](#changes-to-shopifyapi--session)
    + [Changes to how to define resources](#changes-to-how-to-define-resources)
    + [URL construction](#url-construction)
    + [URLs that have not changed](#urls-that-have-not-changed)
- [Using Development Version](#using-development-version)
- [Additional Resources](#additional-resources)
- [Copyright](#copyright)

# Usage

## Requirements

All API usage happens through Shopify applications, created by either shop owners for their shops, or by Shopify Partners for use by other shop owners:

* Shop owners can create applications for themselves through their admin: https://shopify.dev/tutorials/authenticate-a-private-app-with-shopify-admin#generate-private-app-credentials
* Shopify Partners create applications through their admin: http://app.shopify.com/services/partners

For more information and detailed documentation about the API visit https://developers.shopify.com/

### Ruby version

This gem requires Ruby 2.4 as of version 7.0.

## Installation

Add `shopify_api` to your `Gemfile`:

```ruby
gem 'shopify_api'
```

Or install via [gem](http://rubygems.org/)

```bash
gem install shopify_api
```

Once the gem is installed, it must be added to your project by placing the following line in your app :

```ruby
require 'shopify_api'
```

## Getting Started

ShopifyAPI sessions need to be configured with a fully authorized URL of a particular store before they can start making API calls. To obtain that URL, you can follow these steps:

### 1) Create an app

First, create a new application in either the partners admin or your store admin. 

**Private apps** are used for merchant-owned scripts and apps that run silently in the background on a single shop. Private apps aren't able to render any content in the admin. Private apps are created through the store admin.

**Custom apps** are also used for a single shop, but they have access to [app extensions](https://shopify.dev/docs/app-extensions) that allow the app to render content in the admin and are managed and created through the partners dashboard.

**Public apps** can be installed on many stores, and can be added to the Shopify App Store to generate revenue for the developer. 

For a private app, you'll need the API_KEY and the PASSWORD; otherwise, you'll need the API_KEY and SHARED_SECRET.

   If you're not sure how to create a new application in the partner admin, visit the [tutorial in our documentation](https://shopify.dev/tutorials/authenticate-a-public-app-with-oauth#generate-credentials-from-your-partner-dashboard). For the instructions on generating a private app, visit the [tutorial on generating private credentials](https://shopify.dev/tutorials/authenticate-a-private-app-with-shopify-admin#generate-credentials-from-the-shopify-admin)

### 2A) Private Apps

For a private App you just need to set the base site url as follows:

   ```ruby
   shop_url = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com"
   ShopifyAPI::Base.site = shop_url
   ShopifyAPI::Base.api_version = '<version_name>' # find the latest stable api_version here: https://shopify.dev/concepts/about-apis/versioning
   ```

   That's it; you're done! Next, skip to step 6 and start using the API!

### 2B) Public and Custom Apps
   
   For public and custom apps, you will need to supply two parameters to the Session class before you instantiate it:

   ```ruby
   ShopifyAPI::Session.setup(api_key: API_KEY, secret: SHARED_SECRET)
   ```

   Shopify maintains [`omniauth-shopify-oauth2`](https://github.com/Shopify/omniauth-shopify-oauth2), which simplifies and securely wraps the OAuth flow and interactions with Shopify. Using this gem is the recommended way to use OAuth authentication in your application.

### 3) Requesting access from a shop

Public and Custom apps need an access token from each shop to access that shop's data. Getting an access token is a two-stage process. The first stage is to redirect the merchant to a **permission URL** to grant access to the app.

   We've added the `create_permission_url` method to make this easier :

   ```ruby
   # We need to instantiate the session object before using it
   shopify_session = ShopifyAPI::Session.new(domain: "SHOP_NAME.myshopify.com", api_version: api_version, token: nil)
   
# Then, create a permission URL with the session
   permission_url = shopify_session.create_permission_url(scope, "https://my_redirect_uri.com", { state: "My Nonce" })
   ```
   
After creating the permission URL, the user should be directed to this URL to approve the app.

Under the hood, the `create_permission_url` method is preparing the app to make the following request :

   ```
   GET https://SHOP_NAME.myshopify.com/admin/oauth/authorize
   ```

   with the following parameters:

   * ``client_id`` – Required – The API key for your app
   * ``scope`` – Required – The list of required scopes (explained here: https://shopify.dev/tutorials/authenticate-with-oauth#scopes)
   * ``redirect_uri`` – Required – The URL where you want to redirect the users after they authorize the client. The complete URL specified here must be identical to one of the Application Redirect URLs set in the app's section of the Partners dashboard.
   * ``state`` – Optional – A randomly selected value provided by your application, which is unique for each authorization request. During the OAuth callback phase, your application must check that this value matches the one you provided during authorization. [This mechanism is essential for the security of your application](https://tools.ietf.org/html/rfc6819#section-3.6).
   * ``grant_options[]`` - Optional - Set this parameter to `per-user` to receive an access token that respects the user's permission level when making API requests (called online access). We strongly recommend using this parameter for embedded apps.

### 4) Trading your `code` for an access token.

Once authorized, the shop redirects the owner to the return URL of your application with a parameter named `code`. The value of this parameter is a temporary token that the app can exchange for a permanent access token.

   Before you proceed, make sure your application performs the following security checks. If any of the checks fail, your application must reject the request with an error, and must not proceed further.

   1) Ensure the provided ``state`` is the same one that your application provided to Shopify in the previous step.
   2) Ensure the provided hmac is valid. The hmac is signed by Shopify, as explained below in the Verification section.
   3) Ensure the provided hostname parameter is a valid hostname, ends with myshopify.com, and does not contain characters other than letters (a-z), numbers (0-9), dots, and hyphens.

   If all security checks pass, the authorization code can be exchanged once for a permanent access token. There is a method to make the request and get the token for you. Pass all the params received from the previous call and the method will verify the params, extract the temp code and then request your token:

   ```ruby
   token = shopify_session.request_token(params)
   ```

   This method will save the token to the session object and return it. All fields returned by Shopify, other than the access token itself, are stored in the session's `extra` attribute. For a list of all fields returned by Shopify, read [our OAuth documentation](https://shopify.dev/tutorials/authenticate-with-oauth#confirming-installation). 
   
   If you prefer to exchange the token manually, you can make a POST request to the shop with the following parameters :

   ```
   POST https://SHOP_NAME.myshopify.com/admin/oauth/access_token
   ```

   * ``client_id`` – Required – The API key for your app
   * ``client_secret`` – Required – The shared secret for your app
   * ``code`` – Required – The token you received in step 3

   You'll get your permanent access token back in the response.

  If you requested an access token that is associated with a specific user, you can retrieve information about this user from the `extra` hash:

   ```ruby
   # a list of all granted scopes
   granted_scopes = shopify_session.extra['scope']
   # a hash containing the user information
   user = shopify_session.extra['associated_user']
   # the access scopes available to this user, which may be a subset of the access scopes granted to this app.
   active_scopes = shopify_session.extra['associated_user_scope']
   # the time at which this token expires; this is automatically converted from 'expires_in' returned by Shopify
   expires_at = shopify_session.extra['expires_at']
   ```

   For the security of your application, after retrieving an access token, you must validate the following:
   1) The list of scopes in `shopify_session.extra['scope']` is the same as you requested.
   2) If you requested an online-mode access token, `shopify_session.extra['associated_user']` must be present.
   Failing either of these tests means the end-user may have tampered with the URL parameters during the OAuth authentication phase. You should avoid using this access token and revoke it immediately. If you use the [`omniauth-shopify-oauth2`](https://github.com/Shopify/omniauth-shopify-oauth2) gem, these checks are done automatically for you.
   
### 5) Activating the session

Once you have a token, simply pass in the `token` and `extra` hash (optional) when creating the session object:

   ```ruby
   shopify_session = ShopifyAPI::Session.new(domain: "SHOP_NAME.myshopify.com", token: token, api_version: api_version, extra: extra)
   ```

The session must be activated before use:

   ```ruby
   ShopifyAPI::Base.activate_session(shopify_session)
   ```

### 6A) Making requests to the GraphQL API

The GraphQL API is the recommended way to consume the Shopify API. It is more fully-featured than REST, more performant, and future-proof. Whenever possible, GraphQL should be used to consume the Shopify API.

###### Note: the GraphQL client has improved and changed in version 9.0. See the [client documentation](docs/graphql.md) for full usage details and a [migration guide](docs/graphql.md#migration-guide).

This library also supports Shopify's [GraphQL Admin API](https://shopify.dev/docs/admin-api/graphql/reference)
via integration with the [graphql-client](https://github.com/github/graphql-client) gem.
The authentication process (steps 1-5 under [Getting Started](#getting-started))
is identical. Once your session is activated, simply access the GraphQL client
and use `parse` and `query` as defined by
[graphql-client](https://github.com/github/graphql-client#defining-queries).

```ruby
client = ShopifyAPI::GraphQL.client

SHOP_NAME_QUERY = client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = client.query(SHOP_NAME_QUERY)
result.data.shop.name
```

[GraphQL client documentation](docs/graphql.md)

### 6B) Making requests to the REST API

Responses to REST requests are returned as ActiveResource instances:

   ```ruby
   shop = ShopifyAPI::Shop.current

   # Get a specific product
   product = ShopifyAPI::Product.find(179761209)

   # Create a new product
   new_product = ShopifyAPI::Product.new
   new_product.title = "Burton Custom Freestlye 151"
   new_product.product_type = "Snowboard"
   new_product.vendor = "Burton"
   new_product.save

   # Update a product
   product.handle = "burton-snowboard"
   product.save
   ```

   Alternatively, you can use #temp to initialize a Session and execute a command which also handles temporarily setting ActiveResource::Base.site:

   ```ruby
   products = ShopifyAPI::Session.temp(domain: "SHOP_NAME.myshopify.com", token: token, api_version: api_version) do
     ShopifyAPI::Product.find(:all)
   end
   ```

If you would like to run a small number of calls against a different API version you can use this block syntax:

   ```ruby
   ShopifyAPI::Session.temp(domain: "SHOP_NAME.myshopify.com", token: token, api_version: '2019-04') do
     ShopifyAPI::Product.find(:all)  # find call against version `2019-04`

     ShopifyAPI::Session.with_version(:unstable) do
       ShopifyAPI::Product.find(:all)  # find call against version `unstable`
     end

     ShopifyAPI::Product.find(:all)  # find call against version `2019-04`
   end
   ```

If you want to work with another shop, you'll first need to clear the session:

   ```ruby
   ShopifyAPI::Base.clear_session
   ```

## Console

This package also supports the ``shopify-api`` executable to make it easy to open up an interactive console to use the API with a shop.

1. Install the ``shopify_api_console`` gem.

```bash
gem install shopify_api_console
```

2. Obtain a private API key and password to use with your shop (step 2A in "Getting Started")

3. Use the ``shopify-api`` script to save the credentials for the shop to quickly login.

   ```bash
   shopify-api add yourshopname
   ```

   Follow the prompts for the shop domain, API key and password.

4. Start the console for the connection.

   ```bash
   shopify-api console
   ```

5. To see the full list of commands, type:

   ```bash
   shopify-api help
   ```

## Thread safety

ActiveResource is threadsafe as of version 4.1 (which works with Rails 4.x and above).

If you were previously using Shopify's [activeresource fork](https://github.com/shopify/activeresource), then you should remove it and use ActiveResource 4.1.

## Bulk Operations

With the GraphQL Admin API, you can use bulk operations to asynchronously fetch data in bulk. The API is designed to reduce complexity and improve performance when dealing with large volumes of data. 

Instead of manually paginating results and managing a client-side throttle, you can instead run a bulk query operation. Shopify’s infrastructure does the hard work of executing your query, and then provides you with a URL where you can download all of the data.

Apps are limited to running a single bulk operation at a time per shop. When the operation is complete, the results are delivered in the form of a JSONL file that Shopify makes available at a URL.

### Example

The following mutation queries the products connection and returns each product's ID and title.

#### 1) Start the bulk operation

```ruby
client = ShopifyAPI::GraphQL.client

PRODUCTS_BULK_QUERY = client.parse <<-'GRAPHQL'
    mutation {
      bulkOperationRunQuery(
       query: """
        {
          products {
            edges {
              node {
                id
                title
              }
            }
          }
        }
        """
      ) {
        bulkOperation {
          id
          status
        }
        userErrors {
          field
          message
        }
      }
    }
GRAPHQL

result = client.query(PRODUCTS_BULK_QUERY)
```
#### Step 2) Poll the status of the bulk operation

While the operation is running, you need to poll to see its progress using the `currentBulkOperation` field. The `objectCount` field increments to indicate the operation's progress, and the `status` field returns whether the operation is completed.

```ruby
BULK_POLL_QUERY = client.parse <<-'GRAPHQL'
    query {
      currentBulkOperation {
        id
        status
        errorCode
        createdAt
        completedAt
        objectCount
        fileSize
        url
        partialDataUrl
      }
    }
GRAPHQL

result = client.query(BULK_POLL_QUERY)
```

The JSON response of a completed query will look like this :

```json
{
  "data": {
    "currentBulkOperation": {
      "id": "gid:\/\/shopify\/BulkOperation\/720918",
      "status": "COMPLETED",
      "errorCode": null,
      "createdAt": "2019-08-29T17:16:35Z",
      "completedAt": "2019-08-29T17:23:25Z",
      "objectCount": "57",
      "fileSize": "358",
      "url": "https:\/\/storage.googleapis.com\/shopify\/dyfkl3g72empyyoenvmtidlm9o4g?<params>",
      "partialDataUrl": null
    }
  },
  ...
}
```

#### Step 3) Retrieve your data

Since bulk operations are specifically designed to fetch large datasets, we’ve chosen the [JSON Lines](http://jsonlines.org/) (JSONL) format for the response data so that clients have more flexibility in how they consume the data. JSONL is similar to JSON, but each line is a valid JSON object. The file can be parsed one line at a time by using file streaming functionality to avoid issues with memory consumption.

A JSONL output file is available for download at the URL specified in the `url` field when the operation completes.

Each line in the file is a node object returned in a connection. If a node has a nested connection, then each child node is extracted into a new object on the next line. Below is an example of a JSONL file.

```json
{"id":"gid://shopify/Product/1921569226808"}
{"id":"gid://shopify/ProductVariant/19435458986040","title":"70","__parentId":"gid://shopify/Product/1921569226808"}
{"id":"gid://shopify/Product/1921569259576"}
{"id":"gid://shopify/ProductVariant/19435459018808","title":"34","__parentId":"gid://shopify/Product/1921569259576"}
{"id":"gid://shopify/Product/1921569292344"}
{"id":"gid://shopify/ProductVariant/19435459051576","title":"Default Title","__parentId":"gid://shopify/Product/1921569292344"}
{"id":"gid://shopify/Product/1921569325112"}
{"id":"gid://shopify/ProductVariant/19435459084344","title":"36","__parentId":"gid://shopify/Product/1921569325112"}
{"id":"gid://shopify/Product/1921569357880"}
{"id":"gid://shopify/ProductVariant/19435459117112","title":"47","__parentId":"gid://shopify/Product/1921569357880"}
{"id":"gid://shopify/ProductVariant/19435458986123","title":"52","__parentId":"gid://shopify/Product/1921569226808"}
```

Here's a simple example in Ruby to demonstrate the proper way of loading and parsing a JSONL file:

```ruby
# Efficient: reads the file a single line at a time
File.open(file) do |f|
  f.each do |line|
    JSON.parse(line)
  end
end

# Inefficient: reads the entire file into memory
jsonl = File.read(file)

jsonl.each_line do |line|
  JSON.parse(line)
end
```

## Pagination

Shopify uses [Relative cursor-based pagination](https://shopify.dev/tutorials/make-paginated-requests-to-rest-admin-api) to provide more than a single page of results. 

```ruby
products = ShopifyAPI::Product.find(:all, params: { limit: 50 })
process_products(products)
while products.next_page?
  products = products.fetch_next_page
  process_products(products)
end
```

If you want cursor-based pagination to work across page loads, or wish to distribute workload across multiple background jobs, you can use #next_page_info or #previous_page_info methods that return strings:

```
  first_batch_products = ShopifyAPI::Product.find(:all, params: { limit: 50 })
  second_batch_products = ShopifyAPI::Product.find(:all, params: { limit: 50, page_info: first_batch_products.next_page_info })
  ...
```

Relative cursor pagination is currently available for all endpoints using the `2019-10` and later API versions.

Apps using older versions of the API may have used page-based pagination (deprecated starting in 2019-10) :

```ruby
page = 1
products = ShopifyAPI::Product.find(:all, params: { limit: 50, page: page })
process_products(products)
while(products.count == 50)
  page += 1
  products = ShopifyAPI::Product.find(:all, params: { limit: 50, page: page })
  process_products(products)
end
```

# Breaking Change Notices

## Breaking change notice for version 8.0.0

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


## Breaking change notice for version 7.0.0

### Changes to ShopifyAPI::Session
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

### Changes to how to define resources

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

### URL construction

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

### URLs that have not changed

- OAuth URLs for `authorize`, getting the `access_token` from a code, `access_scopes`, and using a `refresh_token` have _not_ changed.
  - get: `/admin/oauth/authorize`
  - post: `/admin/oauth/access_token`
  - get: `/admin/oauth/access_scopes`
- URLs for the merchant’s web admin have _not_ changed. For example: to send the merchant to the product page the url is still `/admin/product/<id>`

# Using Development Version

Download the source code and run:

```bash
bundle install
bundle exec rake test
```

or if you'd rather use docker just run:
```bash
docker run -it --name shopify_api -v "$PWD:/shopify_api" -w="/shopify_api" ruby:2.6 bundle install
docker exec -it shopify_api bash
```

or you can even use our automated rake task for docker:
```bash
bundle exec rake docker
```

# Additional Resources

* [GraphQL API Reference](https://shopify.dev/docs/admin-api/graphql/reference)
* [REST API Reference](https://shopify.dev/docs/admin-api/rest/reference)
* [Ask questions on the forums](https://community.shopify.com/c/Shopify-Community/ct-p/en?profile.language=en)

# Copyright

Copyright (c) 2014 "Shopify Inc.". See LICENSE for details.
