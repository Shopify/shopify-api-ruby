# Make a GraphQL API call

Once you have a [session](https://github.com/Shopify/shopify-ruby-api/blob/master/docs/usage/oauth.md#fetching-sessions) after completing oauth, you can make GraphQL queries to the Admin API with `ShopifyAPI::Clients::Graphql::Admin`

Below is an example

```ruby
# load the current session with SessionUtils.load_current_session
session = ShopifyAPI::Utils::SessionUtils.load_current_session(auth_header: <auth-header>, cookies: <cookies>, is_online: <true|false>)

# initalize the client
client = ShopifyAPI::Clients::Graphql::Admin.new(session)

# make the GraphQL query string
query =<<~QUERY
  {
    products(first: 10) {
      edges {
        cursor
        node {
          id
          title
          onlineStoreUrl
        }
      }
    }
  }
QUERY

response = client.query(query: query)
# do something with the response data
```

You can also make GraphQL calls that take in variables

```ruby
client = ShopifyAPI::Clients::Graphql::Admin.new(session)

query = <<~QUERY
  query testQueryWithVariables($first: Int!){
    products(first: $first) {
      edges {
        cursor
        node {
          id
          title
          onlineStoreUrl
        }
      }
    }
  }
QUERY
variables = {
  first: 3
}

response = client.query(data: query, variables: variables)

```

Here is an example of how you might use fragments as part of the client

```ruby
client = ShopifyAPI::Clients::Graphql::Admin.new(session)
# define the fragment as part of the query
query = <<~QUERY
  fragment ProductStuff on Product {
    id
    title
    description
    onlineStoreUrl
  }
  query testQueryWithVariables($first: Int){
    products(first: $first) {
      edges {
        cursor
        node {
          ...ProductStuff
        }
      }
    }
  }
QUERY
variables = {
  first: 3
}
response = client.query(query: query, variables: variables)
# do something with the reponse
```

Want to make calls to the Storefront API? Click [here](graphql_storefront.md)
