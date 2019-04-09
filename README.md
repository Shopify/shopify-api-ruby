Shopify API
===========
[![Version][gem]][gem_url] [![Build Status](https://travis-ci.org/Shopify/shopify_api.svg?branch=master)](https://travis-ci.org/Shopify/shopify_api)

[gem]: https://img.shields.io/gem/v/shopify_api.svg
[gem_url]: https://rubygems.org/gems/shopify_api


The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores.

The API is implemented as JSON over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation. In other words, we’ve tried to make the API follow the REST principles as much as possible.

## !! Breaking change notice for version 7.0.0 !!

### Changes to ShopifyAPI::Session
Session creation requires `api_version` to be set and now uses keyword arguments

To upgrade your use of ShopifyAPI you will need to make the following changes.

```ruby
ShopifyAPI::Session.new(domain, token, extras)
```
is now
```ruby
ShopifyAPI::Session.new(domain: domain, token: token, api_verison: api_verison, extras: extras)
```
Note `extras` is still optional the other arguments are required.

```ruby
ShopifyAPI::Session.temp(domain, token, extras) do
  ...
end
```
is now
```ruby
ShopifyAPI::Session.temp(domain: domain, token: token, api_verison: api_verison) do
  ...
end
```

The `api_version` attribute can take the string or symbol name of any known version and correctly coerce it to a `ShopifyAPI::ApiVersion`.  You can find the currently defined versions [here](https://github.com/Shopify/shopify_api/blob/master/lib/shopify_api/api_version.rb#L58), follow these [instructions](#adding-aditional-api-versions) to add additional version definitions if needed.

For example if you want to use the `2019-04` version you would create a session like this:
```ruby
session = ShopifyAPI::Session.new(domain: domain, token: token, api_verison: '2019-04')
```
if you want to use the `unstable` version you would create a session like this:
```ruby
session = ShopifyAPI::Session.new(domain: domain, token: token, api_verison: :unstable)
```

### Changes to how to define resources

If you have defined or customized Resources, classes that extend `ShopifyAPI::Base`:
The use of `self.prefix =` has been deprecated you should now use `self.resource =` and not include `/admin`.
For example if you specified a prefix like this before:
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

If you have specifed any full paths for API calls in find
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

## Usage

### Requirements

All API usage happens through Shopify applications, created by either shop owners for their own shops, or by Shopify Partners for use by other shop owners:

* Shop owners can create applications for themselves through their own admin: https://docs.shopify.com/api/authentication/creating-a-private-app
* Shopify Partners create applications through their admin: http://app.shopify.com/services/partners

For more information and detailed documentation about the API visit https://developers.shopify.com/

#### Ruby version

This gem requires Ruby 2.3.1 as of version 4.3. If you need to use an older Ruby version then update your `Gemfile` to lock onto an older release than 4.3.

### Installation

Add `shopify_api` to your `Gemfile`:

```ruby
gem 'shopify_api'
```

Or install via [gem](http://rubygems.org/)

```bash
gem install shopify_api
```

### Getting Started

ShopifyAPI uses ActiveResource to communicate with the REST web service. ActiveResource has to be configured with a fully authorized URL of a particular store first. To obtain that URL you can follow these steps:

1. First create a new application in either the partners admin or your store admin. For a private App you'll need the API_KEY and the PASSWORD otherwise you'll need the API_KEY and SHARED_SECRET.

   If you're not sure how to create a new application in the partner/store admin and/or if you're not sure how to generate the required credentials, you can [read the related shopify docs](https://docs.shopify.com/api/guides/api-credentials) on the same.

2. For a private App you just need to set the base site url as follows:

   ```ruby
   shop_url = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com"
   ShopifyAPI::Base.site = shop_url
   ShopifyAPI::Base.api_verison = '<version_name>' # find the latest stable api_version [here](https://help.shopify.com/api/versioning)
   ```

   That's it, you're done, skip to step 6 and start using the API!

   For a partner app you will need to supply two parameters to the Session class before you instantiate it:

   ```ruby
   ShopifyAPI::Session.setup(api_key: API_KEY, secret: SHARED_SECRET)
   ```

   Shopify maintains [`omniauth-shopify-oauth2`](https://github.com/Shopify/omniauth-shopify-oauth2) which securely wraps the OAuth flow and interactions with Shopify (steps 3 and 4 above). Using this gem is the recommended way to use OAuth authentication in your application.

3. In order to access a shop's data, apps need an access token from that specific shop. This is a two-stage process. Before interacting with a shop for the first time an app should redirect the user to the following URL:

   ```
   GET https://SHOP_NAME.myshopify.com/admin/oauth/authorize
   ```

   with the following parameters:

   * ``client_id`` – Required – The API key for your app
   * ``scope`` – Required – The list of required scopes (explained here: https://help.shopify.com/api/guides/authentication/oauth#scopes)
   * ``redirect_uri`` – Required – The URL where you want to redirect the users after they authorize the client. The complete URL specified here must be identical to one of the Application Redirect URLs set in the App's section of the Partners dashboard. Note: in older applications, this parameter was optional, and redirected to the Application Callback URL when no other value was specified.
   * ``state`` – Optional – A randomly selected value provided by your application, which is unique for each authorization request. During the OAuth callback phase, your application must check that this value matches the one you provided during authorization. [This mechanism is important for the security of your application](https://tools.ietf.org/html/rfc6819#section-3.6).
   * ``grant_options[]`` - Optional - Set this parameter to `per-user` to receive an access token that respects the user's permission level when making API requests (called online access). This is strongly recommended for embedded apps.

   We've added the create_permission_url method to make this easier, first instantiate your session object:

   ```ruby
   shopify_session = ShopifyAPI::Session.new(domain: "SHOP_NAME.myshopify.com", api_version: api_version, token: nil)
   ```

   Then call:

   ```ruby
   scope = ["write_products"]
   permission_url = shopify_session.create_permission_url(scope)
   ```

   or if you want a custom redirect_uri:

   ```ruby
   permission_url = shopify_session.create_permission_url(scope, "https://my_redirect_uri.com")
   ```

4. Once authorized, the shop redirects the owner to the return URL of your application with a parameter named 'code'. This is a temporary token that the app can exchange for a permanent access token.

   Before you proceed, make sure your application performs the following security checks. If any of the checks fails, your application must reject the request with an error, and must not proceed further.

   * Ensure the provided ``state`` is the same one that your application provided to Shopify during Step 3.
   * Ensure the provided hmac is valid. The hmac is signed by Shopify as explained below, in the Verification section.
   * Ensure the provided hostname parameter is a valid hostname, ends with myshopify.com, and does not contain characters other than letters (a-z), numbers (0-9), dots, and hyphens.

   If all security checks pass, the authorization code can be exchanged once for a permanent access token. The exchange is made with a request to the shop.

   ```
   POST https://SHOP_NAME.myshopify.com/admin/oauth/access_token
   ```

   with the following parameters:

   * ``client_id`` – Required – The API key for your app
   * ``client_secret`` – Required – The shared secret for your app
   * ``code`` – Required – The token you received in step 3

   and you'll get your permanent access token back in the response.

   There is a method to make the request and get the token for you. Pass
   all the params received from the previous call and the method will verify
   the params, extract the temp code and then request your token:

   ```ruby
   token = shopify_session.request_token(params)
   ```

   This method will save the token to the session object and return it. All fields returned by Shopify, other than the access token itself, are stored in the session's `extra` attribute. For a list of all fields returned by Shopify, read [our OAuth documentation](https://help.shopify.com/api/guides/authentication/oauth#confirming-installation). If you requested an access token that is associated with a specific user, you can retreive information about this user from the `extra` hash:

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

   For the security of your application, after retrieving an access token you must validate the following:
   1) The list of scopes in `shopify_session.extra['scope']` is the same as you requested.
   2) If you requested an online-mode access token, `shopify_session.extra['associated_user']` must be present.
   Failing either of these tests means the end-user may have tampered with the url parameters during the OAuth authentication phase. You should avoid using this access token and revoke it immediately. If you use the [`omniauth-shopify-oauth2`](https://github.com/Shopify/omniauth-shopify-oauth2) gem these checks are done automatically for you.

   For future sessions simply pass in the `token` and `extra` hash (optional) when creating the session object:

   ```ruby
   shopify_session = ShopifyAPI::Session.new(domain: "SHOP_NAME.myshopify.com", token: token, api_version: api_version, extra: extra)
   ```

5. The session must be activated before use:

   ```ruby
   ShopifyAPI::Base.activate_session(shopify_session)
   ```

6. Now you're ready to make authorized API requests to your shop! Data is returned as ActiveResource instances:

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

7. If you would like to run a small number of calls against a different API version you can use this block syntax:

   ```ruby
   ShopifyAPI::Session.temp(domain: "SHOP_NAME.myshopify.com", token: token, api_version: '2019-04') do
     ShopifyAPI::Product.find(:all)  # find call against version `2019-04`

     ShopifyAPI::Session.with_version(:unstable) do
       ShopifyAPI::Product.find(:all)  # find call against version `unstable`
     end

     ShopifyAPI::Product.find(:all)  # find call against version `2019-04`
   end
   ```

8. If you want to work with another shop, you'll first need to clear the session:

   ```ruby
   ShopifyAPI::Base.clear_session
   ```

### Console

This package also supports the ``shopify-cli`` executable to make it easy to open up an interactive console to use the API with a shop.

1. Install the ``shopify_cli`` gem.

```bash
gem install shopify_cli
```

2. Obtain a private API key and password to use with your shop (step 2 in "Getting Started")

3. Use the ``shopify-cli`` script to save the credentials for the shop to quickly log in.

   ```bash
   shopify-cli add yourshopname
   ```

   Follow the prompts for the shop domain, API key and password.

4. Start the console for the connection.

   ```bash
   shopify-cli console
   ```

5. To see the full list of commands, type:

   ```bash
   shopify-cli help
   ```

## GraphQL

This library also supports Shopify's new [GraphQL API](https://help.shopify.com/api/graphql-admin-api)
via a dependency on the [graphql-client](https://github.com/github/graphql-client) gem.
The authentication process (steps 1-5 under [Getting Started](#getting-started))
is identical. Once your session is activated, simply construct a new graphql
client and use `parse` and `query` as defined by
[graphql-client](https://github.com/github/graphql-client#defining-queries).

```ruby
client = ShopifyAPI::GraphQL.new

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

## Adding aditional API versions
We will release a gem update every time we release a new version of the API. Most of the time upgrading the gem will be all you need to do.

If you want access to a newer version without upgrading you can define an api version.
For example if you wanted to add an `ApiVersion` '2022-03', you would add the following to the initialization of your application:
```ruby
ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2022-03')
```
Once you have done that you can now set this version in a Sesssion like this:

```ruby
ShopifyAPI::Session.new(domain: domain, token: token, api_version: '2022-03')
```


## Threadsafety

ActiveResource is threadsafe as of version 4.1 (which works with Rails 4.x and above).

If you were previously using Shopify's [activeresource fork](https://github.com/shopify/activeresource) then you should remove it and use ActiveResource 4.1.

## Using Development Version

Download the source code and run:

```bash
bundle install
bundle exec rake test
```

## Additional Resources

* [API Reference](https://help.shopify.com/api/reference)
* [Ask questions on the forums](http://ecommerce.shopify.com/c/shopify-apis-and-technology)

## Copyright

Copyright (c) 2014 "Shopify Inc.". See LICENSE for details.
