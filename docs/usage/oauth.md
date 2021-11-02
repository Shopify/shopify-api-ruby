# Performing OAuth

Once the library is set up for your project, you'll be able to use it to start adding functionality to your app. The first thing your app will need to do is to obtain an access token to the Admin API by performing the OAuth process.

To do this, you can follow the steps below.

**Note:** You do not need to go through the Oauth process if you are creating a private app. In this case you can simply set your `<key+password>` as the access_token in `ShopifyAPI::Context.setup`. For more information on authenticating a Shopify app please see the [Types of Authentication](https://shopify.dev/apps/auth#types-of-authentication) page.

## Add a route to start OAuth

The route for starting the OAuth process (in this case `/login`) will use the library's `begin_auth` method. The method will return an `auth_route` URI that will be used for redirecting the user to the Shopify Authentication screen and a session cookie to store on the user's browser. These return values will be a hash in the form of {`auth_route`: `String`, `cookie`: `ShopifyAPI::Auth::Oauth::SessionCookie`}

| Parameter      | Type                   | Required? | Default Value | Notes                                                                                                       |
| -------------- | ---------------------- | :-------: | :-----------: | ----------------------------------------------------------------------------------------------------------- |
| `shop`          | `String`               |    Yes    |       -       | A Shopify domain name in the form `{exampleshop}.myshopify.com`.                                            |
| `redirect_path` | `String`               |    Yes    |       -       | The redirect path used for callback with a leading `/`. The route should be allowed under the app settings. |
| `is_online`     | `Boolean`              |    No     |    `true`     | `true` if the session is online and `false` otherwise.                                                      |

Your app should take the returned values from the `begin_auth` function and redirect the user to url defined by `auth_route` and set the cookie in the user's browser. We strongly recommend that you use secure, httpOnly cookies for this to help prevent session hijacking.

An example is shown below in a Rails app but these steps could be applied in any framework:

```ruby
class ShopifyAuthController < ApplicationController
  def login
    shop = request.headers["Shop"]

    auth_response = ShopifyAPI::Auth::Oauth.begin_auth(shop: domain, redirect_path: "/auth/callback")

    cookies[auth_response[:cookie].name] = {
      expires: auth_response[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_response[:cookie].value
    }

    head 307
    response.set_header("Location", auth_response[:auth_route])
  end
end
```