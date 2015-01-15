[![Build Status](https://travis-ci.org/Shopify/shopify_api.svg?branch=master)](https://travis-ci.org/Shopify/shopify_api)
# Shopify API

The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores.

The API is implemented as JSON over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation. In other words, we’ve tried to make the API follow the REST principles as much as possible.

## Usage

### Requirements

All API usage happens through Shopify applications, created by either shop owners for their own shops, or by Shopify Partners for use by other shop owners:

* Shop owners can create applications for themselves through their own admin: http://docs.shopify.com/api/tutorials/creating-a-private-app
* Shopify Partners create applications through their admin: http://app.shopify.com/services/partners

For more information and detailed documentation about the API visit http://api.shopify.com

### Installation

To easily install or upgrade to the latest release, use [gem](http://rubygems.org/)

```bash
gem install shopify_api
```

### Getting Started

ShopifyAPI uses ActiveResource to communicate with the REST web service. ActiveResource has to be configured with a fully authorized URL of a particular store first. To obtain that URL you can follow these steps:

1. First create a new application in either the partners admin or your store admin. For a private App you'll need the API_KEY and the PASSWORD otherwise you'll need the API_KEY and SHARED_SECRET.

2. For a private App you just need to set the base site url as follows:

   ```ruby
   shop_url = "https://#{API_KEY}:#{PASSWORD}@SHOP_NAME.myshopify.com/admin"
   ShopifyAPI::Base.site = shop_url
   ```

   That's it, you're done, skip to step 6 and start using the API!

   For a partner app you will need to supply two parameters to the Session class before you instantiate it:

  ```ruby
  ShopifyAPI::Session.setup({:api_key => API_KEY, :secret => SHARED_SECRET})
  ```

3. In order to access a shop's data, apps need an access token from that specific shop. This is a two-stage process. Before interacting with a shop for the first time an app should redirect the user to the following URL:

   ```
   GET https://SHOP_NAME.myshopify.com/admin/oauth/authorize
   ```

   with the following parameters:

   * ``client_id``– Required – The API key for your app
   * ``scope`` – Required – The list of required scopes (explained here: http://docs.shopify.com/api/tutorials/oauth)
   * ``redirect_uri`` – Optional – The URL that the merchant will be sent to once authentication is complete. Defaults to the URL specified in the application settings and must be the same host as that URL.

   We've added the create_permission_url method to make this easier, first instantiate your session object:

   ```ruby
   session = ShopifyAPI::Session.new("SHOP_NAME.myshopify.com")
   ```

   Then call:

   ```ruby
   scope = ["write_products"]
   permission_url = session.create_permission_url(scope)
   ```

   or if you want a custom redirect_uri:

   ```ruby
   permission_url = session.create_permission_url(scope, "https://my_redirect_uri.com")
   ```

4. Once authorized, the shop redirects the owner to the return URL of your application with a parameter named 'code'. This is a temporary token that the app can exchange for a permanent access token. Make the following call:

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
   token = session.request_token(params)
   ```

   This method will save the token to the session object and return it. For future sessions simply pass the token in when creating the session object:

   ```ruby
   session = ShopifyAPI::Session.new("SHOP_NAME.myshopify.com", token)
   ```

5. The session must be activated before use:

   ```ruby
   ShopifyAPI::Base.activate_session(session)
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
   products = ShopifyAPI::Session.temp("SHOP_NAME.myshopify.com", token) { ShopifyAPI::Product.find(:all) }
   ```

7. If you want to work with another shop, you'll first need to clear the session:

   ```ruby
   ShopifyAPI::Base.clear_session
   ```


### Console

This package also includes the ``shopify`` executable to make it easy to open up an interactive console to use the API with a shop.

1. Obtain a private API key and password to use with your shop (step 2 in "Getting Started")

2. Use the ``shopify`` script to save the credentials for the shop to quickly log in.

   ```bash
   shopify add yourshopname
   ```

   Follow the prompts for the shop domain, API key and password.

3. Start the console for the connection.

   ```bash
   shopify console
   ```

4. To see the full list of commands, type:

   ```bash
   shopify help
   ```

## Threadsafety

ActiveResource is inherently non-threadsafe, because class variables like ActiveResource::Base.site and ActiveResource::Base.headers are shared between threads. This can cause conflicts when using threaded libraries, like Sidekiq.

We have a forked version of ActiveResource that stores these class variables in threadlocal variables. Using this forked version will allow ShopifyAPI to be used in a threaded environment.

To enable threadsafety with ShopifyAPI, add the following to your Gemfile. There are various threadsafe tags that you can use, [depending on which version of rails you are using](https://github.com/shopify/activeresource/tags).

```
gem 'activeresource', git: 'git://github.com/Shopify/activeresource', tag: '4.2-threadsafe'
gem 'shopify_api', '>= 3.2.1'
```

## Using Development Version

Download the source code and run:

```bash
rake install
```

## Additional Resources

API Docs: http://docs.shopify.com/api

Ask questions on the forums: http://ecommerce.shopify.com/c/shopify-apis-and-technology

## Copyright

Copyright (c) 2014 "Shopify Inc.". See LICENSE for details.
