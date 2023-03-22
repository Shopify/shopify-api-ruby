# Make a Storefront API call

The library also allows you to send GraphQL requests to the [Shopify Storefront API](https://shopify.dev/docs/api/storefront). To do that, you can use `ShopifyAPI::Clients::Graphql::Storefront` with the current session and a `storefrontAccessToken`.

You can obtain Storefront API access tokens for both private apps and sales channels. Please read [our documentation](https://shopify.dev/docs/custom-storefronts/building-with-the-storefront-api/getting-started) to learn more about Storefront Access Tokens.

Below is an example of how you may query the Storefront API:

```ruby
# Load the access token as per instructions above
storefront_access_token = ''
# your shop domain
shop_url = 'shop.myshopify.com'

# initialize the client with session and storefront access token
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, storefront_access_token)

query = <<~QUERY
  {
    collections(first: 2) {
      edges {
        node {
          id
          products(first: 5) {
            edges {
              node {
                id
                title
              }
            }
          }
        }
      }
    }
  }
QUERY

response = client.query(query: query)
# do something with the returned data
```

By default, the client uses the API version configured in `ShopifyAPI`.  To use a different API version, set the optional `api_version` parameter.  To experiment with prerelease API features, use `"unstable"` for the API version.

```ruby
client = ShopifyAPI::Clients::Graphql::Storefront.new(shop_url, storefront_access_token, api_version: "unstable")
```

Want to make calls to the Admin API? Click [here](graphql.md)
