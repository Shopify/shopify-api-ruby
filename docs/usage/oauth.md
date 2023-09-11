# Performing OAuth

Once the library is set up for your project, you'll be able to use it to start adding functionality to your app. The first thing your app will need to do is to obtain an access token to the Admin API by performing the OAuth process.

To do this, you can follow the steps below.
For more information on authenticating a Shopify app please see the [Types of Authentication](https://shopify.dev/docs/apps/auth#types-of-authentication) page.

## Session Persistence
Session persistence is depreciated from the `ShopifyAPI` library gem. The responsibility of session storage typically is fulfilled by the web framework middleware. This API library's focus is on making requests and facilitate session creation.

If you're not using the [ShopifyApp](https://github.com/Shopify/shopify_app) gem, you may use ShopifyAPI to perform OAuth to create sessions, but you must implement your own session storage method to persist the authorized access token.

## Note about Rails
If using in the Rails framework, we highly recommend you use the [shopify_app](https://github.com/Shopify/shopify_app) gem to perform OAuth.

If you aren't using Rails, you can look at how that [gem creates / stores sessions from the OAuth flow](https://github.com/Shopify/shopify_app/blob/2f90af43173041d145f578dcd6448f238b69f9fe/app/controllers/shopify_app/callback_controller.rb#L9) for further examples.

## Performing OAuth
### 1. Add a route to start OAuth
Add a route to your app to start the OAuth process. In this exmple the `ShopifyAuthController`'s `/login` route.
The route for starting the OAuth process should use the library's [`ShopifyAPI::Auth::Oauth.begin_auth`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/oauth.rb#L22) method. 

### `Auth::Oauth.begin_auth` method
#### Input
| Parameter      | Type                   | Required? | Default Value | Notes                                                                                                       |
| -------------- | ---------------------- | :-------: | :-----------: | ----------------------------------------------------------------------------------------------------------- |
| `shop`          | `String`               |    Yes    |       -       | A Shopify domain name in the form `{exampleshop}.myshopify.com`.                                            |
| `redirect_path` | `String`               |    Yes    |       -       | The redirect path used for callback with a leading `/`. The route should be allowed under the app settings. |
| `is_online`     | `Boolean`              |    No     |    `true`     | `true` if the session is online and `false` otherwise.                                                      |

#### Output
`begin_auth` method will return a hash result in the form of:
```ruby
{
  auth_route: String,
  cookie: ShopifyAPI::Auth::Oauth::SessionCookie,
}
```

| Key | Type | Notes |
|-----|------|-------|
|`auth_route`|`String`|URI that will be used for redirecting the user to the Shopify Authentication screen|
|`cookie`|`ShopifyAPI::Auth::Oauth::SessionCookie`|A session cookie to store on the user's browser.|

#### Using the result
Your app should take the returned values from the `begin_auth` method and redirect the user to url defined by `auth_route` and set the cookie in the user's browser. We strongly recommend that you use secure, httpOnly cookies for this to help prevent session hijacking.

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

### 2. Add your OAuth callback route

After the app is authenticated with Shopify, the Shopify platform will send a request back to your app using this route (which you provided as a parameter to `begin_auth`, above). Your app will now use the provided `validate_auth_callback` method to finalize the OAuth process. This method returns a hash containing the new session and a cookie to be set in the browser in form of {`session`: `ShopifyAPI::Auth::Session`, `cookie`: `ShopifyAPI::Auth::Oauth::SessionCookie`}.

An example is shown below in a Rails app but these steps could be applied in any framework:

```ruby
def callback
  begin
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query: ShopifyAPI::Auth::Oauth::AuthQuery.new(request.parameters.symbolize_keys.except(:controller, :action))
    )

    cookies[auth_result[:cookie].name] = {
      expires: auth_result[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_result[:cookie].value
    }

    puts("OAuth complete! New access token: #{auth_result[:session].access_token}")

    head 307
    response.set_header("Location", "<some-redirect-url>")
  rescue => e
    puts(e.message)
    head 500
  end
end
```


