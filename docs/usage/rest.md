# Make a REST API call

Once OAuth is complete, we can use the `ShopifyAPI::Clients::Rest::Admin` client to make an API call to the Shopify Admin API. To do this, you can create an instance of `ShopifyAPI::Clients::Rest::Admin` using the current session to make requests to the Admin API.

## Methods

The Rest Admin client offers the 4 core request methods: `get`, `delete`, `post`, and `put`. These methods each take the parameters outlined in the table below. If the request is successful these methods will all return a `ShopifyAPI::Clients::HttpResponse` object, which has properties `code`, `headers`, and `body` otherwise an error will be raised describing what went wrong.

| Parameter      | Type                                                     | Required in Methods | Default Value | Notes                                                                                                                                                                                                                                                                                  |
| -------------- | -------------------------------------------------------- | :-----------------: | :-----------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `path`         | `String`                                                 |         all         |     none      | The requested API endpoint path. This can be one of two formats:<ul><li>The path starting after the `/admin/api/{version}/` prefix, such as `products`, which executes `/admin/api/{version}/products.json`</li><li>The full path, such as `/admin/oauth/access_scopes.json`</li></ul> |
| `body`         | `Hash(any(Symbol, String), untyped)`                     |    `put`, `post`    |     none      | The body of the request                                                                                                                                                                                                                                                                |
| `query`        | `Hash(any(Symbol, String), any(String, Integer, Float))` |        none         |     none      | An optional query object to be appended to the request url as a query string                                                                                                                                                                                                           |
| `extraHeaders` | `Hash(any(Symbol, String), any(String, Integer, Float))` |        none         |     none      | Any additional headers you want to send with your request                                                                                                                                                                                                                              |
| `tries`        | `Integer`                                                |        None         |      `1`      | The maximum number of times to try the request _(must be >= 0)_                                                                                                                                                                                                                        |

**Note:** _These paramaters can still be used in all methods regardless of if they are required._

## Usage Examples:

### Perform a `GET` request:

```ruby
# Load the current session to get the `accessToken`.
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)

# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session)

# Use `client.get` to request the specified Shopify REST API endpoint, in this case `products`.
response = client.get(path: "products")

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

## Pagination

This library also supports cursor-based pagination for REST Admin API requests. [Learn more about REST request pagination](https://shopify.dev/api/usage/pagination-rest).

After making a request, the `next_page_info` and `prev_page_info` can be found on the response object and passed as the page_info query param in other requests.

An example of this is shown below:

```ruby
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)
client = ShopifyAPI::Clients::Rest::Admin.new(session)

response = client.get(path: "products", query: { limit: 10 })

loop do
  some_function(response.body)
  break unless response.next_page_info
  response =  client.get(path: "products", query: { limit: 10, page_info: response.next_page_info })
end
```

Similarly, when using REST resources the `next_page_info` and `prev_page_info` can be found on the Resource class and passed as the page_info query param in other requests.

An example of this is shown below:

```ruby
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)

products = ShopifyAPI::Product.all(session: session, limit: 10)

loop do
  some_function(products)
  break unless ShopifyAPI::Product.next_page?
  products = ShopifyAPI::Product.all(session: session, limit: 10, page_info: ShopifyAPI::Product.next_page_info)
end
```

The next/previous page_info strings can also be retrieved from the response object and added to a request query to retrieve the next/previous pages.

An example of this is shown below:

```ruby
session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers, cookies, is_online)
client = ShopifyAPI::Clients::Rest::Admin.new(session)

response = client.get(path: "products", query: { limit: 10 })
next_page_info = response.next_page_info

if next_page_info
  next_page_response =client.get(path: "products", query: { limit: 10, page_info: next_page_info })
  some_function(next_page_response)
end
```

### Error Messages

You can rescue `ShopifyAPI::Errors::HttpResponseError` and output error messages with `errors.full_messages`

See example:

```ruby
 fulfillment = ShopifyAPI::Fulfillment.new(session: @session)
  fulfillment.order_id = 2776493818000
  ...
  fulfillment.tracking_company = "Jack Black's Pack, Stack and Track"
  fulfillment.save()
rescue ShopifyAPI::Errors::HttpResponseError => e
  puts fulfillment.errors.full_messages
  # {"base"=>["Line items are already fulfilled"]}
  # If you report this error, please include this id: e712dde0-1270-4258-8cdb-d198792c917e.
```

[Back to guide index](../README.md)
