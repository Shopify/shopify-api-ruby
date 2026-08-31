# Logging App Events

Use `ShopifyAPI.log` to send an App Event to Shopify for a shop where your app is installed. The library mints and caches the app-level Global API access token from the `api_key` and `api_secret_key` configured in `ShopifyAPI::Context`.

`ShopifyAPI.log` is unrelated to `ShopifyAPI::Logger`. `ShopifyAPI::Logger` writes diagnostic output from this library; `ShopifyAPI.log` sends partner-facing App Events to Shopify.

## Find the shop ID

The App Events API requires a numeric shop ID or a Shop GID. If your application only stores the shop domain, query the Admin GraphQL API for the ID:

```graphql
{
  shop {
    id
  }
}
```

The response contains a value such as `gid://shopify/Shop/23423423`. This library does not resolve a shop domain to an ID.

## Log an event

```ruby
result = ShopifyAPI.log(
  shop_id: "gid://shopify/Shop/23423423",
  event_handle: "onboarding_completed",
  idempotency_key: "onboard_23423423_v3",
  attributes: {
    onboarding_version: 3,
    source: "embedded_app",
  },
  timestamp: Time.now,
)

puts "Shopify replayed this event" if result.replayed
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

## Errors and retries

`ShopifyAPI.log` returns `ShopifyAPI::AppEvents::LogResult` after Shopify accepts the event. It raises `ShopifyAPI::Errors::HttpResponseError` for HTTP errors, including `429` responses, which it does not retry.

It refreshes the Global API token once after an event request returns `401`. It retries `409` idempotency conflicts twice and caps each `Retry-After` wait at five seconds.

It raises `ShopifyAPI::Errors::RequestAccessTokenError` when a successful token response does not contain an access token.
