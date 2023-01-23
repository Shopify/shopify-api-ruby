# Make a GraphQL API call

Once you have a [session](oauth.md#fetching-sessions) after completing oauth, you can make GraphQL queries to the Admin API with `ShopifyAPI::Clients::Graphql::Admin`

Below is an example

```ruby
# load the current session with SessionUtils.load_current_session
session = ShopifyAPI::Utils::SessionUtils.load_current_session(auth_header: <auth-header>, cookies: <cookies>, is_online: <true|false>)

# initalize the client
client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)

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
client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)

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

response = client.query(query: query, variables: variables)

```

Here is an example of how you might use fragments as part of the client

```ruby
client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)
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

To experiment with prerelease features, pass the api_version unstable when initializing the client.

```ruby
client = ShopifyAPI::Clients::Graphql::Admin.new(session: session, api_version: "unstable")
```

Want to make calls to the Storefront API? Click [here](graphql_storefront.md)

# Proxy a GraphQL Query

If you would like to give your front end the ability to make authenticated graphql queries to the Shopify Admin API, the `shopify_api` gem makes proxying a graphql request easy! The gem provides a utility function which will accept the raw request body (a GraphQL query), the headers, and the cookies (optional). It will add authentication to the request, proxy it to the Shopify Admin API, and return a `ShopifyAPI::Clients::HttpResponse`. An example utilization of this in Rails is shown below:

```ruby
def proxy
  begin
    response = ShopifyAPI::Utils::GraphqlProxy.proxy_query(
      headers: request.headers.to_h,
      body: request.raw_post,
      cookies: request.cookies.to_h
    )

    render json: response.body, status: response.code
  rescue ShopifyAPI::Errors::InvalidGraphqlRequestError
    # Handle bad request
  rescue ShopifyAPI::Errors::SessionNotFoundError
    # Handle no session found
  end
end
```

**Note:** GraphQL proxying is only supported for online sessions for non-private apps, the utility will raise a `ShopifyAPI::Errors::SessionNotFoundError` if there are no existing online tokens for the provided credentials, and a `ShopifyAPI::Errors::PrivateAppError` if called from a private app.
