# Performing OAuth

Once the library is set up for your project, you'll be able to use it to start adding functionality to your app. The first thing your app will need to do is to obtain an access token to the Admin API by performing the OAuth process.

To do this, you can follow the steps below.
For more information on authenticating a Shopify app please see the [Types of Authentication](https://shopify.dev/docs/apps/auth#types-of-authentication) page.

#### Table of contents
- [Session Persistence](#session-persistence)
- [Supported types of OAuth Flow](#supported-types-of-oauth)
- [Note about Rails](#note-about-rails)
- [Performing OAuth](#performing-oauth-1)
  - [Token Exchange](#token-exchange)
  - [Authorization Code Grant](#authorization-code-grant)
  - [Client Credentials Grant](#client-credentials-grant)
- [Expiring Offline Access Tokens](#expiring-offline-access-tokens)
  - [Refreshing Access Tokens](#refreshing-access-tokens)
  - [Migrating Non-Expiring Tokens to Expiring Tokens](#migrating-non-expiring-tokens-to-expiring-tokens)
- [Using OAuth Session to make authenticated API calls](#using-oauth-session-to-make-authenticated-api-calls)

## Session Persistence
Session persistence is deprecated from the `ShopifyAPI` library gem since [version 12.3.0](https://github.com/Shopify/shopify-api-ruby/blob/main/CHANGELOG.md#version-1230). The responsibility of session storage typically is fulfilled by the web framework middleware.
This API library's focus is on making requests and facilitate session creation.

⚠️ If you're not using the [ShopifyApp](https://github.com/Shopify/shopify_app) gem, you may use ShopifyAPI to perform OAuth to create sessions, but you must implement your own session storage method to persist the session information to be used in authenticated API calls.

## Supported Types of OAuth
> [!TIP]
> If you are building an embedded app, we **strongly** recommend using [Shopify managed installation](https://shopify.dev/docs/apps/auth/installation#shopify-managed-installation)
with [token exchange](#token-exchange) instead of the authorization code grant flow.

1. [Token Exchange](#token-exchange)
    - OAuth flow by exchanging the current user's [session token (shopify id token)](https://shopify.dev/docs/apps/auth/session-tokens) for an
[access token](https://shopify.dev/docs/apps/auth/access-token-types/online.md).
    - Recommended and is only available for embedded apps
    - Doesn't require redirects, which makes authorization faster and prevents flickering when loading the app
    - Access scope changes are handled by [Shopify managed installation](https://shopify.dev/docs/apps/auth/installation#shopify-managed-installation)
2. [Authorization Code Grant](#authorization-code-grant)
    - OAuth flow that requires the app to redirect the user to Shopify for installation/authorization of the app to access the shop's data.
    - Suitable for non-embedded apps
    - Installations, and access scope changes are managed by the app
3. [Client Credentials Grant](#client-credentials-grant)
    - Suitable for apps without a UI
    - Doesn't require user interaction in the browser
    - Access scope changes are handled by [Shopify managed installation](https://shopify.dev/docs/apps/auth/installation#shopify-managed-installation)

## Note about Rails
If using in the Rails framework, we highly recommend you use the [shopify_app](https://github.com/Shopify/shopify_app) gem to perform OAuth, you won't have to follow the instructions below to start your own OAuth flow.
  - See `ShopifyApp`'s [documentation on session storage](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md#sessions)

If you aren't using Rails, you can look at how the `ShopifyApp` gem handles OAuth flow for further examples:
- Token Exchange Flow
  - [Token Exchange](https://github.com/Shopify/shopify_app/blob/main/lib/shopify_app/auth/token_exchange.rb)
    - Completes token exchange flow to get online and offline access tokens
- Authorization Code Grant Flow
    - [Session Controller](https://github.com/Shopify/shopify_app/blob/main/app/controllers/shopify_app/sessions_controller.rb)
      - Triggering and redirecting user to **begin** OAuth flow
    - [Callback Controller](https://github.com/Shopify/shopify_app/blob/main/app/controllers/shopify_app/callback_controller.rb)
      - Creating / storing sessions to **complete** the OAuth flow

## Performing OAuth
### Token Exchange
#### Steps
1. Enable [Shopify managed installation](https://shopify.dev/docs/apps/auth/installation#shopify-managed-installation)
    by configuring your scopes [through the Shopify CLI](https://shopify.dev/docs/apps/tools/cli/configuration).
2. [Perform token exchange](#perform-token-exchange) to get an access token.

#### Perform Token Exchange
Use [`ShopifyAPI::Auth::TokenExchange`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/token_exchange.rb) to
exchange a [session token](https://shopify.dev/docs/apps/auth/session-tokens) (Shopify Id Token) for an [access token](https://shopify.dev/docs/apps/auth/access-token-types/online.md).

#### Input
| Parameter      | Type                   | Required? | Default Value | Notes                                                                                                       |
| -------------- | ---------------------- | :-------: | :-----------: | ----------------------------------------------------------------------------------------------------------- |
| `shop`         | `String` | Yes | - | A Shopify domain name in the form `{exampleshop}.myshopify.com`. |
| `session_token` | `String` | Yes| - | The session token (Shopify Id Token) provided by App Bridge in either the request 'Authorization' header or URL param when the app is loaded in Admin. |
| `requested_token_type` | `TokenExchange::RequestedTokenType` | Yes | - | The type of token requested. Online: `TokenExchange::RequestedTokenType::ONLINE_ACCESS_TOKEN` or offline: `TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN`. |

#### Output
This method returns the new `ShopifyAPI::Auth::Session` object from the token exchange, 
your app should store this `Session` object to be used later [when making authenticated API calls](#using-oauth-session-to-make-authenticated-api-calls).

#### Example
```ruby

# `shop` is the shop domain name - "this-is-my-example-shop.myshopify.com"
# `session_token` is the session token provided by App Bridge either in:
#   - the request 'Authorization' header as `Bearer this-is-the-session_token`
#   - or as a URL param `id_token=this-is-the-session_token`

def authenticate(shop, session_token)
  session = ShopifyAPI::Auth::TokenExchange.exchange_token(
     shop: shop,
     session_token: session_token,
     requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
     # or if you're requesting an online access token:
     # requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::ONLINE_ACCESS_TOKEN,
   )

  SessionRepository.store_session(session)
end

```

### Authorization Code Grant
##### Steps
1. [Add a route to start OAuth](#1-add-a-route-to-start-oauth)
2. [Add an Oauth callback route](#2-add-an-oauth-callback-route)
3. [Begin OAuth](#3-begin-oauth)
4. [Handle OAuth Callback](#4-handle-oauth-callback)

#### 1. Add a route to start OAuth
Add a route to your app to start the OAuth process.

```ruby
class ShopifyAuthController < ApplicationController
  def login
    # This method will trigger the start of the OAuth process
  end
end
```

#### 2. Add an OAuth callback route
After the app is authenticated with Shopify, the Shopify platform will send a request back to your app using this route
(which you will provide as the `redirect_path` parameter to `begin_auth` method, in [step 3 - Begin OAuth](#3-begin-oauth)).
```ruby
class ShopifyCallbackController < ApplicationController
  def callback
    # This callback method will be called once user grants permission to this app from Shopify Admin.
  end
```

#### 3. Begin OAuth
To request access scopes from the shop during authorization code grant OAuth flow, 
configure access scopes needed by adding the `scope` parameter to the `ShopifyAPI::Context.setup` method in your configuration.

```ruby
ShopifyAPI::Context.setup(
  api_key: <SHOPIFY_API_KEY>,
  api_secret_key: <SHOPIFY_API_SECRET>,
  api_version: <SHOPIFY_API_VERSION>,
  scope: <SHOPIFY_API_SCOPES>, # Accepts array or string: "read_orders, write_products" or ["read_orders", "write_products"]
  ...
  )
```

Use [`ShopifyAPI::Auth::Oauth.begin_auth`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/oauth.rb#L22) method to start OAuth process for your app.

#### Input
| Parameter      | Type                   | Required? | Default Value | Notes                                                                                                       |
| -------------- | ---------------------- | :-------: | :-----------: | ----------------------------------------------------------------------------------------------------------- |
| `shop`          | `String`               |    Yes    |       -       | A Shopify domain name in the form `{exampleshop}.myshopify.com`.                                            |
| `redirect_path` | `String`               |    Yes    |       -       | The redirect path used for callback with a leading `/`. The route should be allowed under the app settings. |
| `is_online`     | `Boolean`              |    No     |    `true`     | `true` if the session is online and `false` otherwise.                                                      |
| `scope_override`| `String` or `[String]` |    No     |     `nil`     |  `nil` will request access scopes configured in `ShopifyAPI::Context.setup` during OAuth flow. Modify this to override the access scopes being requested. Accepts array or string: "read_orders, write_products" or ["read_orders", "write_products"]. |

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

##### Example
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

#### 4. Handle OAuth Callback
When the user grants permission to the app in Shopify admin, they'll be redirected back to the app's callback route
(configured in [Step 2 - Add an OAuth callback route](#2-add-an-oauth-callback-route)).

Use [`ShopifyAPI::AuthL::Oauth.validate_auth_callback`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/oauth.rb#L60) method to finalize the OAuth process.

##### Input
| Parameter    | Type    | Notes                                                                                                       |
| ------------ | --------| ----------------------------------------------------------------------------------------------------------- |
| `cookies`    | `Hash`  | All browser cookies in a hash format with key and value as `String` |
| `auth_query` | `ShopifyAPI::Auth::Oauth::AuthQuery`| An `AuthQuery` containing the authorization request information used to validate the request.|

##### Output
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

##### Example
Your app should call `validate_auth_callback` to construct the `Session` object and cookie that will be used later for authenticated API requests.

1. Call `validate_auth_callback` to construct `Session` and `SessionCookie`.
2. Update browser cookies with the new value for the session.
3. Store the `Session` object to be used later when [making authenticated API calls](#using-oauth-session-to-make-authenticated-api-calls).
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

    # Store the Session object if your app has a DB/file storage for session persistence
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

### Client Credentials Grant

> [!NOTE]
> You can only use the client credentials grant when building apps for your own organization.

> [!WARNING]
> [token exchange](#token-exchange) (for embedded apps) or the [authorization code grant](#authorization-code-grant) should be used instead of the client credentials grant, if your app is a browser based web app.

#### Perform Client Credentials Grant
Use [`ShopifyAPI::Auth::ClientCredentials`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/client_credentials.rb) to
exchange the [app's client ID and client secret](https://shopify.dev/docs/apps/build/authentication-authorization/client-secrets) for an access token.
#### Input
| Parameter      | Type                   | Required? | Default Value | Notes                                                                                                       |
| -------------- | ---------------------- | :-------: | :-----------: | ----------------------------------------------------------------------------------------------------------- |
| `shop`         | `String` | Yes | - | A Shopify domain name in the form `{exampleshop}.myshopify.com`. |

#### Output
This method returns the new `ShopifyAPI::Auth::Session` object from the client credentials grant, your app should store this `Session` object to be used later [when making authenticated API calls](#using-oauth-session-to-make-authenticated-api-calls).

#### Example
```ruby

# `shop` is the shop domain name - "this-is-my-example-shop.myshopify.com"

def authenticate(shop)
  session = ShopifyAPI::Auth::ClientCredentials.client_credentials(
     shop: shop,
   )
  SessionRepository.store_session(session)
end

```

## Expiring Offline Access Tokens


To start requesting expiring offline access tokens, set the `expiring_offline_access_tokens` parameter to `true` when setting up the Shopify context:

```ruby
ShopifyAPI::Context.setup(
  api_key: <SHOPIFY_API_KEY>,
  api_secret_key: <SHOPIFY_API_SECRET>,
  api_version: <SHOPIFY_API_VERSION>,
  scope: <SHOPIFY_API_SCOPES>,
  expiring_offline_access_tokens: true, # Enable expiring offline access tokens
  ...
)
```

When enabled:
- **Authorization Code Grant**: The OAuth flow will request expiring offline access tokens by sending `expiring: 1` parameter
- **Token Exchange**: When requesting offline access tokens via token exchange, the flow will request expiring tokens

The resulting `Session` object will contain:
- `access_token`: The access token that will eventually expire
- `expires`: The expiration time for the access token
- `refresh_token`: A token that can be used to refresh the access token
- `refresh_token_expires`: The expiration time for the refresh token

### Refreshing Access Tokens

When your access token expires, you can use the refresh token to obtain a new access token using the `ShopifyAPI::Auth::RefreshToken.refresh_access_token` method.

#### Input
| Parameter      | Type     | Required? | Notes                                                                                           |
| -------------- | -------- | :-------: | ----------------------------------------------------------------------------------------------- |
| `shop`         | `String` | Yes       | A Shopify domain name in the form `{exampleshop}.myshopify.com`.                               |
| `refresh_token`| `String` | Yes       | The refresh token from the session.                                                             |

#### Output
This method returns a new `ShopifyAPI::Auth::Session` object with a fresh access token and a new refresh token. Your app should store this new session to replace the expired one.

#### Example
```ruby
def refresh_session(shop, refresh_token)
  begin
    # Refresh the access token using the refresh token
    new_session = ShopifyAPI::Auth::RefreshToken.refresh_access_token(
      shop: shop,
      refresh_token: refresh_token
    )

    # Store the new session, replacing the old one
    MyApp::SessionRepository.store_shop_session(new_session)
  rescue ShopifyAPI::Errors::HttpResponseError => e
    puts("Failed to refresh access token: #{e.message}")
    raise e
  end
end
```
#### Checking Token Expiration
The `Session` object provides helper methods to check if tokens have expired:

```ruby
session = MyApp::SessionRepository.retrieve_shop_session_by_shopify_domain(shop)

# Check if the access token has expired
if session.expired?
  # Access token has expired, refresh it
  new_session = ShopifyAPI::Auth::RefreshToken.refresh_access_token(
    shop: session.shop,
    refresh_token: session.refresh_token
  )
  MyApp::SessionRepository.store_shop_session(new_session)
end

# Check if the refresh token has expired
if session.refresh_token_expired?
  # Refresh token has expired, need to re-authenticate with OAuth
end
```

### Migrating Non-Expiring Tokens to Expiring Tokens

If you have existing non-expiring offline access tokens and want to migrate them to expiring tokens, you can use the `ShopifyAPI::Auth::TokenExchange.migrate_to_expiring_token` method. This performs a token exchange that converts your non-expiring offline token into an expiring one with a refresh token.

> [!WARNING]
> This is a **one-time, irreversible migration** per shop. Once you migrate a shop's token to an expiring token, you cannot convert it back to a non-expiring token. The shop would need to reinstall your app with `expiring_offline_access_tokens: false` in your Context configuration to obtain a new non-expiring token.

#### Input
| Parameter      | Type     | Required? | Notes                                                                                           |
| -------------- | -------- | :-------: | ----------------------------------------------------------------------------------------------- |
| `shop`         | `String` | Yes       | A Shopify domain name in the form `{exampleshop}.myshopify.com`.                               |
| `non_expiring_offline_token` | `String` | Yes | The non-expiring offline access token to migrate. |

#### Output
This method returns a new `ShopifyAPI::Auth::Session` object with an expiring access token and refresh token. Your app should store this new session to replace the non-expiring one.

#### Example
```ruby
def migrate_shop_to_expiring_offline_token(shop)
  # Retrieve the existing non-expiring session
  old_session = MyApp::SessionRepository.retrieve_shop_session_by_shopify_domain(shop)

  # Migrate to expiring token
  new_session = ShopifyAPI::Auth::TokenExchange.migrate_to_expiring_token(
    shop: shop,
    non_expiring_offline_token: old_session.access_token
  )

  # Store the new expiring session, replacing the old one
  MyApp::SessionRepository.store_shop_session(new_session)
end
```

#### Migration Strategy
When migrating your app to use expiring tokens, follow this order:

1. **Update your database schema** to add `expires_at` (timestamp), `refresh_token` (string) and `refresh_token_expires` (timestamp) columns to your session storage
2. **Implement refresh logic** in your app to handle token expiration using `ShopifyAPI::Auth::RefreshToken.refresh_access_token`
3. **Enable expiring tokens in your Context setup** so new installations will request and receive expiring tokens:
   ```ruby
   ShopifyAPI::Context.setup(
     expiring_offline_access_tokens: true,
     # ... other config
   )
   ```
4. **Migrate existing non-expiring tokens** for shops that have already installed your app using the migration method above

## Using OAuth Session to make authenticated API calls
Once your OAuth flow is complete, and you have persisted your `Session` object, you may use that `Session` object to make authenticated API calls.

Example:
```ruby
def make_api_request(shop)
  # 1. Retrieve the Session object stored from previous step
  session = MyApp::SessionRepository.retrieve_session_for_shop(shop)

  # 2. Create API client with the session information
  # session must be type `ShopifyAPI::Auth::Session`
  graphql_client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)

  # 3. Use API client to make queries
  response = graphql_client.query(query: MY_API_QUERY)

  # 4. Use the response for your app
  ...
end
```

#### Setting `active_session`
Alternatively, if you don't want to keep having to retrieve a Session object for a shop, you may set [`ShopifyAPI::Context.active_session`](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/context.rb#L144).
All of the API client classes will [use the `active_session`](https://github.com/Shopify/shopify-api-ruby/blob/c3bb9d8f8b6053756149a4cf9299e059ec337544/lib/shopify_api/clients/http_client.rb#L13) if the `session` passed in is `nil`.

Example:
```ruby
#### Configuration
def configure_app
  # This method is called before making authenticated API calls
  session = retrieve_session_from_file # your implementation of retrieving a session

  # Activate session to be used in all API calls
  # session must be type `ShopifyAPI::Auth::Session`
  ShopifyAPI::Context.activate_session(session)

end

#### Using clients to make authenticated API calls
def make_api_request
  # 1. Create API client without session information
  # The graphql_client will use `ShopifyAPI::Context.active_session` when making API calls
  graphql_client = ShopifyAPI::Clients::Graphql::Admin.new

  # 2. Use API client to make queries
  ...
end

```

⚠️ See following docs on how to use the API clients:
- [Make a GraphQL API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/graphql.md)
- [Make a REST API call](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/rest.md)
