# Logging App Events

`ShopifyAPI.log` sends one App Events request using the Global API access token you pass in. Mint the token with `ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials`, which returns a `ShopifyAPI::Auth::GlobalApiToken` (`access_token`, `expires_at`) and mints a new token on every call. The library does not cache tokens; cache `access_token` until `expires_at` in your application.

`ShopifyAPI.log` is unrelated to `ShopifyAPI::Logger`. `ShopifyAPI::Logger` writes diagnostic output from this library; `ShopifyAPI.log` sends partner-facing App Events to Shopify.

## Identify the shop

Pass `myshopify_domain:` as `example.myshopify.com`. The library also accepts `https://example.myshopify.com` and `https://admin.shopify.com/store/example` and normalizes them to `example.myshopify.com`.

Numeric IDs, Shop GIDs, and untrusted domains raise `ShopifyAPI::Errors::InvalidShopError`.

## Log an event

```ruby
token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

result = ShopifyAPI.log(
  myshopify_domain: "example.myshopify.com",
  event_handle: "onboarding_completed",
  idempotency_key: "onboard_23423423_v3",
  attributes: {
    onboarding_version: 3,
    source: "embedded_app",
  },
  access_token: token.access_token,
  timestamp: Time.now,
)
```

The app must be installed on the target shop. The App Events API requires `attributes`, so pass `{}` when the event carries no data. `timestamp` is optional; the library uses the current time when you omit it.

The `idempotency_key` must be unique across all shops for your app. Shopify keys the idempotency cache by app and key, not by shop. Reusing one key for different shops can replay the first response instead of recording the later event.

## Global API version

App Events is served by the Global API, which is versioned separately from the Admin API. Configure `global_api_version` independently from `ShopifyAPI::Context.api_version`.

The supported Global API versions are `unstable`, `2026-10`, and `2026-07`. The current default is `2026-10`.

```ruby
ShopifyAPI::Context.setup(
  # ...
  api_version: "2026-07",
  global_api_version: "2026-10",
)
```

## Target a non-production Shopify environment

The Global API defaults to `https://api.shopify.com`. Override `global_api_url` only when Shopify provides a different Global API host for a non-production environment:

```ruby
ShopifyAPI::Context.setup(
  # ...
  global_api_url: "https://api.shop.dev",
)
```

`global_api_url` must be an absolute HTTPS URL.

## Errors

`ShopifyAPI.log` returns `ShopifyAPI::AppEvents::LogResult` after Shopify accepts the event. It raises `ShopifyAPI::Errors::HttpResponseError` for every HTTP error, including `401`, `409`, and `429`. It sends exactly one request and never retries.

It raises `ShopifyAPI::Errors::MissingRequiredArgumentError` for a blank `access_token`. After a `401`, mint a new token in your application and call `ShopifyAPI.log` again.

It raises `ShopifyAPI::Errors::RequestAccessTokenError` when a successful token response does not contain an access token.
