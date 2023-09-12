# Performing OAuth

Once the library is set up for your project, you'll be able to use it to start adding functionality to your app. The first thing your app will need to do is to obtain an access token to the Admin API by performing the OAuth process.

To do this, you can follow the steps below.
For more information on authenticating a Shopify app please see the [Types of Authentication](https://shopify.dev/docs/apps/auth#types-of-authentication) page.

## Session Persistence
Session persistence is depreciated from the `ShopifyAPI` library gem since [version 12.3.0](https://github.com/Shopify/shopify-api-ruby/blob/main/CHANGELOG.md#version-1230). The responsibility of session storage typically is fulfilled by the web framework middleware.
This API library's focus is on making requests and facilitate session creation.

If you're not using the [ShopifyApp](https://github.com/Shopify/shopify_app) gem, you may use ShopifyAPI to perform OAuth to create sessions, but you must implement your own session storage method to persist the authorized access token.

## Note about Rails
If using in the Rails framework, we highly recommend you use the [shopify_app](https://github.com/Shopify/shopify_app) gem to perform OAuth.
  - See `ShopifyApp`'s [documentation on sessions](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md#sessions)

If you aren't using Rails, you can look at how the [ShopifyApp gem creates / stores sessions from the OAuth flow](https://github.com/Shopify/shopify_app/blob/2f90af43173041d145f578dcd6448f238b69f9fe/app/controllers/shopify_app/callback_controller.rb#L9) for further examples.

## Performing OAuth
#### Steps
1. [Add a route to start OAuth](#1--add-a-route-to-start-oauth)
2. [Add an Oauth callback route](#2--add-an-oauth-callback-route)
3. [Begin OAuth](#3--begin-oauth)
4. [Handle OAuth Callback](#4--handle-oauth-callback)

### 1. Add a route to start OAuth
Add a route to your app to start the OAuth process.

```ruby
class ShopifyAuthController < ApplicationController
  def login
    # This method will trigger the start of the OAuth process
  end
end
```

### 2. Add an OAuth callback route
After the app is authenticated with Shopify, the Shopify platform will send a request back to your app using this route
(which you will provide as the `redirect_path` parameter to `begin_auth` method, in [step 3 - Begin OAuth](#3--begin-oauth)).
```ruby
class ShopifyCallbackController < ApplicationController
  def callback
    # This callback method will be called once user grants permission to this app from Shopify Admin.
  end
```

### 3. Begin OAuth
Use [`ShopifyAPI::Auth::Oauth.begin_auth`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/oauth.rb#L22) method to start OAuth process for your app.

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
|`cookie`|`ShopifyAPI::Auth::Oauth::SessionCookie`|A session cookie to store on the user's browser. |

#### Example
Your app should take the returned values from the `begin_auth` method and:

1. Set the cookie in the user's browser. We strongly recommend that you use secure, httpOnly cookies for this to help prevent session hijacking.
2. Redirect the user to authorization url defined by `auth_route`.
   - This will redirect the user to the Shopify Admin page to authorize/grant permission to the app.

An example is shown below in a Rails app but these steps could be applied in any framework:

```ruby
class ShopifyAuthController < ApplicationController
  def login
    shop = request.headers["Shop"]

    # Builds the authorization URL route to redirect the user to
    auth_response = ShopifyAPI::Auth::Oauth.begin_auth(shop: domain, redirect_path: "/auth/callback")

    # Store the authorization cookie
    cookies[auth_response[:cookie].name] = {
      expires: auth_response[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_response[:cookie].value
    }

    # Redirect the user to "auth_response[:auth_route]" to allow user to grant the app permission
    # This will lead the user to the Shopify Authorization page
    head 307
    response.set_header("Location", auth_response[:auth_route])
  end
end
```

⚠️ You can see a concrete example in the `ShopifyApp` gem's [SessionController](https://github.com/Shopify/shopify_app/blob/main/app/controllers/shopify_app/sessions_controller.rb).

### 4. Handle OAuth Callback
When the user grants permission to the app in Shopify admin, they'll be redirected back to the app's callback route
(configured in [Step 2 - Add your OAuth callback route](#2--add-your-oauth-callback-route)).

Use [`ShopifyAPI::AuthL::Oauth.validate_auth_callback`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/oauth.rb#L60) method to finalize the OAuth process.

#### Input
| Parameter    | Type    | Notes                                                                                                       |
| ------------ | --------| ----------------------------------------------------------------------------------------------------------- |
| `cookies`    | `Hash`  | All browser cookies in a hash format with key and value as `String` |
| `auth_query` | `ShopifyAPI::Auth::Oauth::AuthQuery`| An `AuthQuery` containing the authorization request information used to validate the request.|

#### Output
This method returns a hash containing the new session and a cookie to be set in the browser in form of:
```ruby
{
    session: ShopifyAPI::Auth::Session,
    cookie: ShopifyAPI::Auth::Oauth::SessionCookie,
}
```
| Key | Type | Notes |
|-----|------|-------|
|`session`|`ShopifyAPI::Auth::Session`|A session object that contains necessary information to identify the session like `shop`, `access_token`, `scope`, etc.|
|`cookie` |`ShopifyAPI::Auth::Oauth::SessionCookie`|A session cookie to store on the user's browser. |

#### Example
Your app should call `validate_auth_callback` to construct the `Session` object and cookie that will be used later for authenticated API requests.

1. Call `validate_auth_callback` to construct `Session` and `SessionCookie`.
2. Update browser cookies with the new value for the session.
3. Store the `Session` object to be used later when making authenticated API calls.
   - See [Make a GraphQL API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/graphql.md), or
   [Make a REST API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/rest.md) for examples on how to use the result `Session` object.

An example is shown below in a Rails app but these steps could be applied in any framework:

```ruby
def callback
  begin
    # Create an AuthQuery object from the request parameters,
    # and pass the list of cookies to `validate_auth_callback`
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query: ShopifyAPI::Auth::Oauth::AuthQuery.new(
        request.parameters.symbolize_keys.except(:controller, :action)
      )
    )

    # Update cookies with the authorized access token from result
    cookies[auth_result[:cookie].name] = {
      expires: auth_result[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_result[:cookie].value
    }

    # Store the Session object if your app has a DB storage for session persistence
    # This session object could be retrieved later to make authenticated API requests to Shopify
    MyApp::SessionRepository.store_session(auth_result[:session])

    puts("OAuth complete! New access token: #{auth_result[:session].access_token}")

    head 307
    response.set_header("Location", "<some-redirect-url>")
  rescue => e
    puts(e.message)
    head 500
  end
end
```

⚠️ You can see a concrete example in the `ShopifyApp` gem's [CallbackController](https://github.com/Shopify/shopify_app/blob/main/app/controllers/shopify_app/callback_controller.rb).

