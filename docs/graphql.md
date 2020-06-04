# GraphQL client

The `shopify_api` gem includes a full featured GraphQL client to interact with
Shopify's [GraphQL Admin API](https://help.shopify.com/en/api/graphql-admin-api).
GitHub's [graphql-client](https://github.com/github/graphql-client) is used as
the underlying client and this library integrates it with our existing
session, authentication, and API versioning features.

## Example

```ruby
client = ShopifyAPI::GraphQL.client

SHOP_NAME_QUERY = client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = client.query(SHOP_NAME_QUERY)
result.data.shop.name
```

* [Getting started](#getting-started)
* [Rails integration](#rails-integration)
* [API versioning](#api-versioning)
* [Initialization process](#initialization-process)
* [Migration guide](#migration-guide)

## Getting started

1. [Dump the schema](#dump-the-schema)
2. [Configure session/authencation](#sessions-and-authentication)
3. [Make queries](#make-queries)

### Dump the schema
One of the main benefits of GraphQL is its [schema and type system](https://graphql.org/learn/schema/)
which enables tools like graphql-client to ensure your queries are valid in development.

So the first step in making GraphQL queries is having a local JSON file of Shopify's Admin schema.
This gem provides a `shopify_api:graphql:dump` Rake task to make it as easy as possible:

#### Private apps
```bash
$ rake shopify_api:graphql:dump SHOP_URL="https://API_KEY:PASSWORD@SHOP_NAME.myshopify.com" API_VERSION=2020-01
```
#### Public apps
```bash
$ rake shopify_api:graphql:dump SHOP_DOMAIN="SHOP_NAME.myshopify.com" ACCESS_TOKEN="SHOP_TOKEN" API_VERSION=2020-01
```

If successful `db/shopify_graphql_schemas/2020-01.json` will be created.

You can either use private app authentication or an OAuth access token. Run `rake shopify_api:graphql:dump`
to see full usage details.

If you're using shopify_api in a Rails app, the default location for schema files is `db/shopify_graphql_schemas`.
For non-Rails applications, the default is `shopify_graphql_schemas` in your project root.

The schema path location can be changed via `ShopifyAPI::GraphQL.schema_location`:

```ruby
ShopifyAPI::GraphQL.schema_location = 'assets/schemas'
```

#### Updating schemas
Each time you want to use a new API version, or update an existing one
(such as the `unstable` version), simply run the Rake task again to overwrite the file.

### Sessions and authentication
The GraphQL client is designed to be integrated with the rest of shopify_api so
all its features such as sessions, authentication, and API versioning work the
exact same.

If you've already been using the shopify_api gem in your application to make
REST API calls then no other configuration is necessary.

Steps 1-5 of our main [Getting started](https://github.com/Shopify/shopify_api#getting-started)
section still apply for the GraphQL client as well.

### Make queries
Now that you've dumped a schema file and configured an authenticated session, you can make GraphQL API requests.
graphql-client encourages all queries to be defined statically as constants:

```ruby
SHOP_NAME_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = ShopifyAPI::GraphQL.client.query(SHOP_NAME_QUERY)
result.data.shop.name
```

But we've also enabled its `allow_dynamic_queries` option if you prefer:

```ruby
query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = ShopifyAPI::GraphQL.client.query(query)
result.data.shop.name
```

See the [graphql-client documentation](https://github.com/github/graphql-client#defining-queries)
for more details on defining and executing queries.

## Rails integration
`ShopifyAPI::GraphQL` integrates with Rails to automatically do the following:

* load the `shopify_api:graphql:dump` Rake task
* set the `schema_location` to be in the `db` directory in your Rails root
* initialize clients in the Rails app initializer phase

## API versioning
`ShopifyAPI::GraphQL` is version aware and lets you easily make queries to multiple
API versions through version specific clients if need be.

If you have multiple clients and need to be explicit you can specify the version parameter:

```ruby
ShopifyAPI::GraphQL.client # defaults to the client using ShopifyAPI::Base.api_version
ShopifyAPI::GraphQL.client('unstable')
```

## Initialization process
`ShopifyAPI::GraphQL` is a thin integration layer which initializes `GraphQL::Client`s
from local schema files.

`ShopifyAPI::GraphQL.initialize_clients` scans `ShopifyAPI::GraphQL.schema_location`
and creates a client for each version specific schema file found.

This happens automatically in a Rails application due to our [integration](#rails-integration).
For non-Rails applications, ensure you call `ShopifyAPI::GraphQL.initialize_clients`
during your boot process.

The goal is to have all clients created at boot so there's no schema loading,
parsing, or client instantiation done during runtime when your app serves a request.

## Using a custom client
`ShopifyAPI::GraphQL::HTTPClient` inherits from `::GraphQL::Client::HTTP` and instruments
the headers, url and api version for you. However, you may find that you wish to add
additional functionality to the client responsible for executing and parsing queries.
For instance, you may wish to create a client which loads responses from a file for your
tests, or you may want to implement a client which raises errors instead of passing them
back through the results object.

To set a custom client set `ShopifyAPI::GraphQL.client_klass` to your client:
```ruby
class RaisingHTTPClient < ShopifyAPI::GraphQL::HTTPClient
  def execute(document:, operation_name: nil, variables: {}, context: {})
    result = super
    do_work(result)
  end

  private

  def do_work(result)
    result
  end
end

ShopifyAPI::GraphQL.client_klass = RaisingHTTPClient
```

## Migration guide
Prior to shopify_api v9.0 the GraphQL client implementation was limited and almost
unusable due to the client making dynamic introspection queries to Shopify's API.
This was not only very slow but also led to unbounded memory growth.

There are two steps to migrate to the new client:
1. [Dump a local schema file](#dump-the-schema)
2. [Migrate `client` usage](#migrate-usage)

### Migrate usage

Previously a client was initialized with `ShopifyAPI::GraphQL.new`:
```ruby
client = ShopifyAPI::GraphQL.new

SHOP_NAME_QUERY = client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = client.query(SHOP_NAME_QUERY)
result.data.shop.name
```

Now there's no need to initialize a client so all references to
`ShopifyAPI::GraphQL.new` should be removed and instead the client is called
via `ShopifyAPI::GraphQL.client`:

```ruby
client = ShopifyAPI::GraphQL.client

SHOP_NAME_QUERY = client.parse <<-'GRAPHQL'
  {
    shop {
      name
    }
  }
GRAPHQL

result = client.query(SHOP_NAME_QUERY)
result.data.shop.name
```

See [make queries](#make-queries) for more usage details.
