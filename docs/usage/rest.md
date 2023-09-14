# Make a REST API call

Once OAuth is complete, we can use `ShopifyAPI`'s REST library to make authenticated API calls to the Shopify Admin API.
#### Required Session
Every API request requires a valid
[ShopifyAPI::Auth::Session](https://github.com/Shopify/shopify-api-ruby/blob/main/lib/shopify_api/auth/session.rb).

To instantiate a session, we recommend you either use the `shopify_app` if working in Rails, or refer to our OAuth docs on constructing a session:
 - ["Performing OAuth"](https://github.com/Shopify/shopify-api-ruby/blob/main/docs/usage/oauth.md) - documentation on how to create new sessions
 - [[ShopifyApp] - "Session"](https://github.com/Shopify/shopify_app/blob/main/docs/shopify_app/sessions.md) - documentation on session handling if you're using the [`ShopifyApp`](https://github.com/Shopify/shopify_app) gem.

#### There are 2 methods you can use to make REST API calls to Shopify:
- [Using REST Resources](#using-rest-resources)
  - Resource classes with similar syntax as `ActiveResource`, and follows our REST convention. Example:
  ``` ruby
  # Update product title
  product = ShopifyAPI::Product.find(id: <product_id>)
  product.title = "My awesome product"
  product.save!
  ```

- [Using REST Admin Client](#using-rest-admin-client)
  - More manual input method to make the API call. Example:
  ```ruby
  # Create a new client.
  rest_client = ShopifyAPI::Clients::Rest::Admin.new

  # Update product title
  body = {
    product: {
      title: "My cool product"
    }
  }

  # Use `client.put` to send your request to the specified Shopify Admin REST API endpoint.
  rest_client.put(path: "products/<id>.json", body: body)
  ```

## Using REST Resources

## Using REST Admin Client
Create an instance of `ShopifyAPI::Clients::Rest::Admin` using the current session to make requests to the Admin API.

##### Table of Content:
- [Methods](#methods)
  - [Input Parameters](#method-input-parameters)
  - [Output](#output)
- [Usage Examples](#usage-examples)
- [Pagination](#pagination)

### Methods

The Rest Admin client offers the 4 core request methods:
- `get`
- `delete`
- `post`
- `put`

#### Input Parameters

Each method can take the parameters outlined in the table below. 

| Parameter      | Type                                                     | Required in Methods | Default Value | Notes                                                                                                                                                                                                                                                                                  |
| -------------- | -------------------------------------------------------- | :-----------------: | :-----------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `path`         | `String`                                                 |         all         |     none      | The requested API endpoint path. This can be one of two formats:<ul><li>The path starting after the `/admin/api/{version}/` prefix, such as `products`, which executes `/admin/api/{version}/products.json`</li><li>The full path, such as `/admin/oauth/access_scopes.json`</li></ul> |
| `body`         | `Hash(any(Symbol, String), untyped)`                     |    `put`, `post`    |     none      | The body of the request                                                                                                                                                                                                                                                                |
| `query`        | `Hash(any(Symbol, String), any(String, Integer, Float))` |        none         |     none      | An optional query object to be appended to the request url as a query string                                                                                                                                                                                                           |
| `extraHeaders` | `Hash(any(Symbol, String), any(String, Integer, Float))` |        none         |     none      | Any additional headers you want to send with your request                                                                                                                                                                                                                              |
| `tries`        | `Integer`                                                |        None         |      `1`      | The maximum number of times to try the request _(must be >= 0)_                                                                                                                                                                                                                        |

**Note:** _These parameters can still be used in all methods regardless of if they are required._

#### Output
If the request is successful these methods will all return a `ShopifyAPI::Clients::HttpResponse` object, which has properties `code`, `headers`, and `body` otherwise an error will be raised describing what went wrong.

### Usage Examples:
#### Perform a `GET` request:

```ruby
# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

# Use `client.get` to request the specified Shopify REST API endpoint, in this case `products`.
response = client.get(path: "products")

# Do something with the returned data
some_function(response.body)
```

#### Perform a `POST` request:

```ruby
# Create a new client.
client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

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

_for more information on the `products` endpoint, [check out our API reference guide](https://shopify.dev/docs/api/admin-rest/unstable/resources/product)._

#### Override the `api_version`:

```ruby
# To experiment with prerelease features, pass the api_version "unstable".
client = ShopifyAPI::Clients::Rest::Admin.new(session: session, api_version: "unstable")
```

### Pagination

This library also supports cursor-based pagination for REST Admin API requests. [Learn more about REST request pagination](https://shopify.dev/docs/api/usage/pagination-rest).

After making a request, the `next_page_info` and `prev_page_info` can be found on the response object and passed as the page_info query param in other requests.

An example of this is shown below:

```ruby
client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

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
client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

response = client.get(path: "products", query: { limit: 10 })
next_page_info = response.next_page_info

if next_page_info
  next_page_response =client.get(path: "products", query: { limit: 10, page_info: next_page_info })
  some_function(next_page_response)
end
```

#### Error Messages

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
