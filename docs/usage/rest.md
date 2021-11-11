# Make a REST API call

Once OAuth is complete, we can use the `ShopifyAPI::Clients::Rest::Admin` client to make an API call to the Shopify Admin API. To do this, you can create an instance of `ShopifyAPI::Clients::Rest::Admin` using the current session to make requests to the Admin API.

## Methods

The Rest Admin client offers the 4 core request methods: `get`, `delete`, `post`, and `put`. These methods each take the parameters outlined in the table below. If the request is successful these methods will all return a `ShopifyAPI::Clients::HttpResponse` object, which has properties `code`, `headers`, and `body` otherwise an error will be raised describing what went wrong.

| Parameter | Type | Required in Methods | Default Value | Notes |
| -------------- | ----------------------------------- | :-------: | :-----------: | ---------------------------------------------------------------------------------------- |
| `path` | `String` | all | none | The requested API endpoint path. Do not prepend with `/`. |
| `body` | `Hash(any(Symbol, String), untyped)` | `put`, `post` | none | The body of the request |
| `query` | `Hash(any(Symbol, String), any(String, Integer, Float))` | none | none | An optional query object to be appended to the request url as a query string |
| `extraHeaders` | `Hash(any(Symbol, String), any(String, Integer, Float))` | none | none | Any additional headers you want to send with your request |
| `tries` | `Integer` | None | `1` | The maximum number of times to try the request _(must be >= 0)_ |

**Note:** *These paramaters can still be used in all methods regardless of if they are required.*

## Usage Examples:

### Perform a `GET` request:

```ruby
# Load the current session to get the `accessToken`.
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)

# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session)

# Use `client.get` to request the specified Shopify REST API endpoint, in this case `products`.
response = client.get(path: "products");

# Do something with the returned data
some_function(response.body)
```

### Perform a `POST` request:

```ruby
# Load the current session to get the `accessToken`.
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)

# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session)

# Build your post request body.
body = { 
  product: { 
    title: "Burton Custom Freestyle 151", 
    body_html: "\u003cstrong\u003eGood snowboard!\u003c\/strong\u003e",
    vendor: "Burton",
    product_type: "Snowboard", 
  }
}

# Use `client.post` to send your request to the specified Shopify Admin REST API endpoint.
client.post({
  path: "products",
  body: body,
});
```

_for more information on the `products` endpoint, [check out our API reference guide](https://shopify.dev/api/admin-rest/unstable/resources/product)._

[Back to guide index](../README.md)