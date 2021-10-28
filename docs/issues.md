# Known issues and caveats

By following this guide, you will have a fully functional Shopify app. However, there are some things you should be aware of before using your new app in a production environment.

## Notes on session handling

Before you start writing your application, please note that the Shopify library needs to store some information for OAuth in sessions. Since each application may choose a different strategy to store information, the library cannot dictate any specific storage strategy. When calling `ShopifyAPI::Context.setup`, you'll need to provide an instance of a class that implements the `ShopifyAPI::Auth::SessionStorage` interface.

This library provides a very simple implementation of that interface which stores sessions in files, `ShopifyAPI::Auth::FileSessionStorage` ([source code](../lib/shopify_api/auth/file_session_storage.rb)). This class is meant to speed up development with this library, but it is not suitable for production use, because it will lead to disk build-up as old sessions are not cleaned up.

Before you deploy your app to production, it should use your selected storage method for sessions. You can do that by creating a class that implements the `SessionStorage` interface and pass that in your `Context.setup` call. Your class will need to implement the methods below.

**Note**: After you create your implementation of `SessionStorage`, you should make sure to clean up old sessions periodically in your data storage. The library will delete some sessions when they are no longer useful, but it cannot guarantee that expired sessions are deleted automatically.

#### `SessionStorage.storeSession`

Creates **or updates** a `Session` object in your storage. This function should return a `bool` indicating whether the operation was successful.

| Param     | Type      | Notes                       |
| --------- | --------- | --------------------------- |
| `session` | `Session` | The session object to store |

#### `SessionStorage.loadSession`

Fetches a `Session` object from your storage. This function should return a `Session` object, or `null` if it was not found.

| Param       | Type     | Notes                         |
| ----------- | -------- | ----------------------------- |
| `sessionId` | `string` | The id of the session to load |

#### `SessionStorage.deleteSession`

Deletes a session from your storage. This function should return a `bool` indicating whether the operation was successful.

| Param       | Type     | Notes                           |
| ----------- | -------- | ------------------------------- |
| `sessionId` | `string` | The id of the session to delete |

[Back to guide index](README.md)