
# Create a Session Storage Implementation

The implementation of session storage that you pass in `ShopifyAPI::Context.setup` is what the Shopify gem will use to store and load sessions. [Shopify::Auth::FileSessionStorage](../../lib/shopify_api/auth/file_session_storage.rb) can be used for testing purposes and as an example of how to make an implementation in your app. This is not recommended for production, we recommend you implement a solution that will store and load serialized sessions from a more ideal store such as a database like MySQL or MongoDB.

## Create a New Session Storage Class

You can create a session storage class that includes `ShopifyAPI::Auth::SessionStore` and override the methods as shown in the table and example below:

|       Method Name      |             Input Type            |           Return Type          |
| ---------------------- | --------------------------------- | ------------------------------ |
| `store_session`        | `ShopifyAPI::Auth::Session`       | `Boolean` (true if successful) |
| `load_session`         | `String` (session id)             | `ShopifyAPI::Auth::Session`    |
| `delete_session`       | `String` (session id)             | `Boolean` (true if successful) |


```ruby
class CustomSessionStorage
  include ShopifyAPI::Auth::SessionStorage

  def initialize
    # Initialize as needed
  end

  def store_session(session)
    # Implement a store function
    some_store_function(id: session.id, session_data: session.serialize)
  end

  def load_session(id)
    # Implement a fetch function
    session_data = some_fetch_function(id)
    ShopifyAPI::Auth::Session.deserialize(session_data)
  end

  def delete_session(id)
    # Implement a delete function
    some_delete_function(id)
    true
  end
end
```

**Note:** We recommend utilizing the Session `serialize` and `deserialize` functions to make storing and loading sessions easier.

Once this is complete you can pass an instance of this session storage class as `session_storage` in `ShopifyAPI::Context.setup`
