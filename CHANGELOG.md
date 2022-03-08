## Unreleased

## Version 9.5.1

- [#891](https://github.com/Shopify/shopify_api/pull/891) Removed the upper bound on the `activeresource` dependency to allow apps to use the latest version

## Version 9.5

* [#883](https://github.com/Shopify/shopify_api/pull/883) Add support for Ruby 3.0

## Version 9.4.1

* [#847](https://github.com/Shopify/shopify_api/pull/847) Update `create_permission_url` method to use grant_options
* [#852](https://github.com/Shopify/shopify_api/pull/852) Bumping kramdown to fix a security vulnerability

## Version 9.4.0

* [#843](https://github.com/Shopify/shopify_api/pull/843) Introduce a new `access_scopes` attribute on the Session class.
  * Specifying this in the Session constructor is optional. By default, this attribute returns `nil`.

## Version 9.3.0

* [#797](https://github.com/Shopify/shopify_api/pull/797) Release new Endpoint `fulfillment_order.open` and `fulfillment_order.reschedule`.

* [#818](https://github.com/Shopify/shopify_api/pull/818) Avoid depending on ActiveSupport in Sesssion class.

* Freeze all string literals. This should have no impact unless your application is modifying ('monkeypatching') the internals of the library in an unusual way.

* [#802](https://github.com/Shopify/shopify_api/pull/802) Made `inventory_quantity` a read-only field in Variant

* [#821](https://github.com/Shopify/shopify_api/pull/821) Add logging based on environment variable, move log subscriber out of `detailed_log_subscriber`.
  The `ActiveResource::DetailedLogSubscriber` no longer automatically attaches when the class is loaded. If you were previously relying on that behaviour, you'll now need to call `ActiveResource::DetailedLogSubscriber.attach_to(:active_resource_detailed)`. (If using the new `SHOPIFY_LOG_PATH` environment setting then this is handled for you).

* Provide `ApiAccess` value object to encapsulate scope operations [#829](https://github.com/Shopify/shopify_api/pull/829)

## Version 9.2.0

* Removes the `shopify` binary which will be used by the Shopify CLI

## Version 9.1.1

* Make cursor based pagination return relative uri's when fetching next and previous pages. [#726](https://github.com/Shopify/shopify_api/pull/726)

## Version 9.1.0

* Implements equality operator on `Session` [#714](https://github.com/Shopify/shopify_api/pull/714)

## Version 9.0.4

* Contains [#708](https://github.com/Shopify/shopify_api/pull/708) which is a revert for [#655](https://github.com/shopify/shopify_api/pull/655) due to the deprecated inventory parameters not being removed correctly in some cases

## Version 9.0.3

* We now raise a `ShopifyAPI::ValidationException` exception when clients try to use `Product` and `Variant` with deprecated inventory-related fields in API version `2019-10` or later. [#655](https://github.com/shopify/shopify_api/pull/655) Deprecation and migration information can be found in the following documents:
  * [Product Variant REST API Reference](https://shopify.dev/docs/admin-api/rest/reference/products/product-variant)
  * [Migrate your app to support multiple locations](https://shopify.dev/tutorials/migrate-your-app-to-support-multiple-locations)
  * [Manage product inventory with the Admin API](https://shopify.dev/tutorials/manage-product-inventory-with-admin-api)
* Added support for the Discount Code API batch endpoints [#701](https://github.com/shopify/shopify_api/pull/701)
  * [Create](https://shopify.dev/docs/admin-api/rest/reference/discounts/discountcode#batch_create-2020-01)
  * [Show](https://shopify.dev/docs/admin-api/rest/reference/discounts/discountcode#batch_show-2020-01)
  * [List](https://shopify.dev/docs/admin-api/rest/reference/discounts/discountcode#batch_discount_codes_index-2020-01)
* Fix issue in the README to explicitly say clients need to require the `shopify_api` gem [#700](https://github.com/Shopify/shopify_api/pull/700)

## Version 9.0.2

* Added optional flag passed to `initialize_clients` to prevent from raising the `InvalidSchema` exception [#693](https://github.com/Shopify/shopify_api/pull/693)

## Version 9.0.1

* Added warning message if API version used is unsupported or soon to be unsupported  [#685](https://github.com/Shopify/shopify_api/pull/685)
* Take into account "errors" messages from response body [#677](https://github.com/Shopify/shopify_api/pull/677)

## Version 9.0.0

* Breaking change: Improved GraphQL client [#672](https://github.com/Shopify/shopify_api/pull/672). See the [client docs](docs/graphql.md) for usage and a migration guide.

* Added options hash to create_permission_url and makes redirect_uri required [#670](https://github.com/Shopify/shopify_api/pull/670)

* Release new Endpoint `fulfillment_order.locations_for_move` in 2020-01 REST API version [#669](https://github.com/Shopify/shopify_api/pull/669)

* Release new Endpoints for `fulfillment` in 2020-01 REST API version [#639](https://github.com/Shopify/shopify_api/pull/639):
  * `fulfillment.create` with `line_items_by_fulfillment_order`
  * `fulfillment.update_tracking`
  * `fulfillment.cancel`

* Release new Endpoints for `fulfillment_order` in 2020-01 REST API version [#637](https://github.com/Shopify/shopify_api/pull/637):
  * `fulfillment_order.fulfillment_request`
  * `fulfillment_order.fulfillment_request.accept`
  * `fulfillment_order.fulfillment_request.reject`
  * `fulfillment_order.cancellation_request`
  * `fulfillment_order.cancellation_request.accept`
  * `fulfillment_order.cancellation_request.reject`

* Release new Endpoints `fulfillment_order.move`, `fulfillment_order.cancel` and `fulfillment_order.close` in 2020-01 REST API version [#635](https://github.com/Shopify/shopify_api/pull/635)

* Release new Endpoint `order.fulfillment_orders`, and active resources `AssignedFulfillmentOrder` and `FulfillmentOrder` in 2020-01 REST API version [#633](https://github.com/Shopify/shopify_api/pull/633)

## Version 8.1.0

* Release 2020-01 REST ADMIN API VERSION [#656](https://github.com/Shopify/shopify_api/pull/656)
* Release new Endpoint `collection.products` and `collection.find()` in 2020-01 REST API version [#657](https://github.com/Shopify/shopify_api/pull/657)
* Enrich 4xx errors with error message from response body [#647](https://github.com/Shopify/shopify_api/pull/647)
* Make relative cursor based pagination work across page loads [#625](https://github.com/Shopify/shopify_api/pull/625)
* Small ruby compat fix [#623](https://github.com/Shopify/shopify_api/pull/623)
* Small consistency change [#621](https://github.com/Shopify/shopify_api/pull/621)

## Version 8.0.0

* Api Version changes [#600](https://github.com/Shopify/shopify_api/pull/600)
  * Remove static Api Version definitions.
  * Introduces Api Version lookup modes: `:define_on_unknown` and `:raise_on_unknown`
  * See [migration notes](README.md#-breaking-change-notice-for-version-800-)
* `Session.valid?` checks that api_version `is_a?(ApiVersion)` instead of `present?`
* `ApiVersion::NullVersion` cannot be instantiated and now has a `match?` method [#615](https://github.com/Shopify/shopify_api/pull/615/files)
* Introduces new Collection endpoint for looking up products without knowing collection type. Only available if ApiVersion is `:unstable` [#609](https://github.com/Shopify/shopify_api/pull/609)

## Version 7.1.0

* Add 2019-10 to known API versions
* Add support for cursor pagination [#594](https://github.com/Shopify/shopify_api/pull/594) and
[#611](https://github.com/Shopify/shopify_api/pull/611)
* `ShopifyAPI::Base.api_version` now defaults to `ShopifyAPI::ApiVersion::NullVersion` instead of `nil`. Making requests without first setting an ApiVersion raises `ApiVersionNotSetError` instead of `NoMethodError: undefined method 'construct_api_path' for nil:NilClass'` [#605](https://github.com/Shopify/shopify_api/pull/605)

## Version 7.0.2

* Add 2019-07 to known API versions.

## Version 7.0.1

* Support passing version string to `ShopifyAPI::Base.api_version` [#563](https://github.com/Shopify/shopify_api/pull/563)

## Version 7.0.0

* Removed support for `ActiveResouce` < `4.1`.
* Removed `ShopifyAPI::Oauth`.
* Added api version support, See [migration
notes](README.md#-breaking-change-notice-for-version-700-)
* Changed `ShopifyAPI::Session` method signatures from positional to keyword
arguments, See [migration notes](README.md#-breaking-change-notice-for-version-700-)
* Add support for newer call limit header `X-Shopify-Shop-Api-Call-Limit`.
* Removed all Ping resources.

## Version 6.0.0

* Removed undocumented `protocol` and `port` options from `ShopifyAPI::Session`.

## Version 5.2.4

* Added `currency` parameter to `ShopifyAPI::Order#capture`. This parameter is required for apps that belong to the
multi-currency beta program.

## Version 5.2.3

* Update delivery confirmation resource to delivery confirmation details resource.

## Version 5.2.2

* Add delivery confirmation endpoint to Ping resources.

## Version 5.2.1

* Log warning when Shopify indicates deprecated API call was performed

## Version 5.2.0

* Added `ShopifyAPI::Currency` to fetch list of supported currencies on a shop
* Added `ShopifyAPI::TenderTransaction` to fetch list of transactions on a shop
* Fixed bug with X-Shopify-Checkout-Version on ShopifyAPI::Checkout header being applied to all requests

## Version 5.1.0

* Added `ShopifyAPI::Publications`
* Added `ShopifyAPI::ProductPublications`
* Added `ShopifyAPI::CollectionPublications`
* Added support for new collection products endpoint from `ShopifyAPI::Collection#products`

## Version 5.0.0

* Breaking change: `ShopifyAPI::Checkout` now maps to the Checkout API, rather than the Abandoned Checkouts API
  * See the README for more details
* Added `ShopifyAPI::AbandonedCheckout`
* Added support for X-Shopify-Checkout-Version header on `ShopifyAPI::Checkout`
* Added `ShopifyAPI::ShippingRate`
* Added `ShopifyAPI::Payment`
* Added support for `Checkout::complete` endpoint
* Fixed session handling support for Rails 5.2.1

## Version 4.13.0
* Added `ShopifyAPI::ApiPermission` resource for uninstalling an application
* Added a deprecation warning to `ShopifyAPI::OAuth`

## Version 4.12.0

* Added support for the GraphQL API

## Version 4.11.0

* Added `ShopifyAPI::InventoryItem`
* Added `ShopifyAPI::InventoryLevel`
* Added `#inventory_levels` method to `ShopifyAPI::Location`

## Version 4.10.0

* Added `ShopifyAPI::AccessScope`

## Version 4.9.1

* Fix a bug with custom properties for orders

## Version 4.9.0

* Added `ShopifyAPI::PriceRule`
* Added `ShopifyAPI::DiscountCode`

## Version 4.8.0

* Added `add_engagements` to `ShopifyAPI::MarketingEvent`

## Version 4.7.1

* Added support for URL parameter (e.g. limit & page) to ShopifyAPI::Metafields
* Added support for URL parameter (e.g. limit & page) to metafield operator in ShopifyAPI::Shop

## Version 4.7.0

* Removed the mandatory `application_id` parameter from `ShopifyAPI::ProductListing` and `ShopifyAPI::CollectionListing`
* Fixed a bug related to the non-standard primary key for `ShopifyAPI::ProductListing` and `ShopifyAPI::CollectionListing`

## Version 4.6.0

* Added `ShopifyAPI::Report`

## Version 4.5.0

* Added `ShopifyAPI::MarketingEvent`

## Version 4.4.0

* Added `ShopifyAPI::CustomerInvite`
* Support for Customer#send_invite endpoint

## Version 4.3.8

* Added `ShopifyAPI::ResourceFeedback`

## Version 4.3.7

* Added support for `complete` in `ShopifyAPI::DraftOrder`

## Version 4.3.6

* Fixed the `customer_saved_search_id` param in `ShopifyAPI::CustomerSavedSearch#customers`.

## Version 4.3.5

* Added support for online mode access tokens, token expiry, and associated_user information.
* Added `ShopifyAPI::DraftOrder`
* Added `ShopifyAPI::DraftOrderInvoice`

## Version 4.3.4

* Added `ShopifyAPI::ProductListing`
* Added `ShopifyAPI::CollectionListing`

## Version 4.3.3

* Added `ShopifyAPI::StorefrontAccessToken`

## Version 4.3.2

* Relax Ruby version requirement to >= `2.0`

## Version 4.3.1

* Support for ShopifyAPI::ApplicationCredit

## Version 4.3.0

* Require Ruby >= `2.3.0`
* Use inheritance instead of the deprecated Rails `Module#alias_method_chain`

## Version 4.2.2

* Support for AccessToken#delegate endpoint

## Version 4.2.1

* Support for Users and Discounts (Shopify Plus only)
* Adds Customer#account_activation_url method
* Adds ability to open a fulfillment.

## Version 4.2.0

* Threadsafety is now compatible with the latest ActiveResource master

## Version 4.1.1

* Added explicit 90 second timeout to `ShopifyAPI::Base`

## Version 4.0.7

* Added `ShippingAPI::ShippingZone`

## Version 4.0.6

* Replaced `cancelled` with `expired` in `ShopifyAPI::ApplicationCharge`

## Version 4.0.5

* Added `pending`, `cancelled`, `accepted`, `declined` helper methods to `ShopifyAPI::ApplicationCharge`

## Version 4.0.4

* Fixed truthiness for order cancellations. Requests are now sent in the request body and as JSON

## Version 4.0.3

* Fixed hmac signature validation for params with delimiters (`&`, `=` or `%`)

## Version 4.0.2

* Verify that the shop domain is a subdomain of .myshopify.com which creating the session

## Version 4.0.1

* Added `ShopifyAPI::OAuth.revoke` for easy token revocation.

## Version 3.2.6

* Fixed CustomerSavedSearch#customers method to now correctly return only relevant customers

## Version 3.2.5

* More useful error messages for activating nil sessions
* Add tests for commonly deleted objects, and metafield tests, fix naming error in order_risk_test.rb

## Version 3.2.4

* No API changes

## Version 3.2.3

* Added pry to the CLI

## Version 3.2.2

* Temporary fix for the CLI
* Add a specific exception for signature validation failures

## Version 3.2.1

* Added CarrierService resource
* Added optionally using threadsafe ActiveResource (see readme)
* Fixed bug in validate_signature

## Version 3.2.0

* in Session::request_token params is no longer optional, you must pass all the params and the method will now extract the code
* Fixed JSON errors handling (#103)
* Fixed compatibility with Ruby 2.1.x (#83)
* Fixed getting parent ID from nested resources like Variants (#44)
* Cleaned up compatibility with ActiveResource 4.0.x
* Added OrderRisk resource
* Added FulfillmentService resource
* Removed discontinued ProductSearchEngine resource
* Added convenience method Customer#search (#45)

## Version 3.1.8

* Expose `index` and `show` actions of `Location`
* Added create_permission_url and request_token helper methods
* Edited the readme to better describe the getting started procedure

## Version 3.1.7

* Expose `authors` and `tags` action on Article

## Version 3.1.6

* Add LineItem::Property resource

## Version 3.1.5

* Expose `orders` action on Customer

## Version 3.1.3

* Expose `complete` action on Fulfillment

## Version 3.1.2

* Includes port in domain URI (when other than http/80 or https/443)
* Adds access to CustomerSavedSearch
* Adds resources: Order::DefaultAddress, Client::ClientDetails, Announcement
* Allows access to Articles without a blog_id
* Moves encode and as_json overrides to ShopifyAPI::Base scope
* Exposes the `order` action in SmartCollection for general use

## Version 3.0.3

* Add a `customers` helper method to the CustomerGroup resource

## Version 3.0.2

* Brevity in require statements

## Version 3.0.1

* Fix saving nested resources in ActiveResource 3.1+

## Version 3.0.0

* Added support for OAuth Authentication
* Removal of support for Legacy Authentication
* Added Cart resource

## Version 2.3.0

* Fix double root bug with ActiveSupport 3.2.0
* Add metafields methods on Customer resource
* Fix prefix_options on assets returned from Asset.find

## Version 2.2.0

* Fix issues with resources that have both direct and namespaced routes
* Added detailed logger to help with debugging ActiveResource
requests/responses
* Add fulfillment#cancel

## Version 2.1.0

* Fix JSON errors handling
* Remove global limit from ShopifyAPI::Limits

## Version 2.0.0

* Bump to 2.0.0 as this release breaks Rails 2 compatibility; we're now officially only supporting Rails 3. Rails 2 devs can follow the rails2 tag in this repo to know where we broke off
* Refactored resources into their own source files
* Added API limits functionality
* Patched ActiveResource issue with roots in JSON
* Added pending, cancelled, accepted, and declined convenience methods to ShopifyAPI::RecurringApplicationCharge
* ShopifyAPI::Session#temp now available as a convenience method to support temporarily switching to other shops when making calls
* Fixes to `shopify console` CLI tool

## Version 1.2.5

* Fix for Article#comments

## Version 1.2.4

* Added Article#comments
* Added Order#cancel
* Added Comment#restore, #not_spam

## Version 1.2.3

* Added Customer, CustomerGroup support

## Version 1.2.2

* Added ScriptTag support

## Version 1.2.1

* Allow abbreviated names for all commands like rails does, e.g. 'shopify c' instead of 'shopify console'
* Fix Variant to support accessing both nested variants with a product prefix as well as top level variants directly
* Add 'grande' to supported product image size variants

## Version 1.2.0

* Command-line interface
* Allow custom params when fetching a single Asset

## Version 1.1.3 (November 4, 2010)

* Add ProductSearchEngines resource

## Version 1.1.2 (October 20, 2010)

* Fix for users of ActiveResource 3.x

## Version 1.1.1 (October 5, 2010)

* Remove hard coded xml formatting in API calls
* Remove jeweler stuff
* Ruby 1.9 encoding fix

## Version 1.1.0 (September 24, 2010)

* Add new Events API for Shop, Order, Product, CustomCollection, SmartCollection, Page, Blog and Article
* Add new 'compact' product image size variant
* Rails 3 fix: attribute_accessors has to be explicitly included since activesupport 3.0.0

## Version 1.0.6

* Add metafields
* Add latest changes from Shopify including asset support, token validation and a common base class

## Version 1.0.0

* extracting ShopifyAPI from Shopify into Gem
