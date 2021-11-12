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

## Add your OAuth callback route

After the app is authenticated with Shopify, the Shopify platform will send a request back to your app using this route (which you provided as a parameter to `begin_auth`, above). Your app will now use the provided `validate_auth_callback` method to finalize the OAuth process. This method returns a hash containing the new session and a nilable cookie to be set in the browser in form of {`session`: `ShopifyAPI::Auth::Session`, `cookie`: `ShopifyAPI::Auth::Oauth::SessionCookie`}.

An example is shown below in a Rails app but these steps could be applied in any framework:

```ruby
def callback
  begin
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query: ShopifyAPI::Auth::Oauth::AuthQuery.new(request.parameters.symbolize_keys.except(:controller, :action))
    )

    puts("OAuth complete! New access token: #{auth_result[:session].access_token}")

    head 307
    response.set_header("Location", "<some-redirect-url>")
  rescue => e
    puts(e.message)  
    head 500
  end
end
```
## Fetching sessions

You can use the OAuth methods to create both offline and online sessions. Once the process is completed, the session will be stored as per your `Context.session_storage`, and can be retrieved with `SessionUtils` class methods.

- To load current session, you can use the following method:

```ruby
ShopifyAPI::Auth::SessionUtils.load_current_session(headers, cookies, is_online)
```
Accepted arguments:
| Parameter   | Type                      | Notes                                                                                                                                                                     |
| ----------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `headers`   | `Hash(Symbol, String)`    | The headers from the HTTP request. JWT token from `headers` is used to load session for embedded apps. If JWT token is not provided this methods will try with `cookies`. |
| `cookies`   | `Hash(Symbol, String)`    | The cookies from the HTTP request. A session cookie named `shopify_app_session` is used to load session for non-embedded apps.                                            |
| `is_online` | `Boolean`                 | Whether to load online or offline sessions                                                                                                                                |

This method will return a `ShopifyAPI::Auth::Session`  if a session exists. Either a proper token or a proper cookie must be present.

- To load offline session, you can use the following method:

```ruby
ShopifyAPI::Auth::SessionUtils.load_offline_session(shop)
```
Accepted arguments:
| Parameter           | Type      | Notes                                                                                                                                                                     |
| ------------------- | --------- | --------------------------------------------- |
| `shop`              | `String`  | The shop url to find the offline session for. |
| `include_expired`   | `Boolean` | Include expired sessions or not.              |

This method will return a `ShopifyAPI::Auth::Session` if a session exists and `nil` otherwise. This method **does not** perform any validation on the shop domain, so it **must not** rely on user input for the domain. This method is typically meant to be used in background tasks like webhooks, where the data is expected to have been validated when the task was enqueued.
