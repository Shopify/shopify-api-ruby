# Webhooks

The `shopify_api` gem provides webhook functionality to make it easy to both subscribe to and process webhooks. To implement in your app follow the steps outlined below.

## Create a Webhook Handler

If you want to register for an http webhook you need to implement a webhook handler which the `shopify_api` gem can use to determine how to process your webhook. You can make multiple implementations (one per topic) or you can make one implementation capable of handling all the topics you want to subscribe to. To do this simply make a module or class that includes or extends `ShopifyAPI::Webhooks::WebhookHandler` and implement the handle method which accepts the following named parameters: topic: `String`, shop: `String`, and body: `Hash[String, untyped]`. An example implementation is shown below:

```ruby
module WebhookHandler 
  include ShopifyAPI::Webhooks::Handler

  class << self
    def handle(topic:, shop:, body:)
      puts "Received webhook! topic: #{topic} shop: #{shop} body: #{body}"
    end
  end
end
```

**Note:** It is recommended that in order to respond quickly to the Shopify webhook request that the handler not do any heavy logic or network calls, rather it should simply enqueue the work in some job queue in order to be executed later.

## Add to Webhook Registry

The next step is to add all the webhooks you would like to subscribe to for any shop to the webhook registry. To do this you can call `ShopifyAPI::Webhooks::Registry.add_registration` for each webhook you would like to handle. `add_registration` accepts a topic string, a delivery_method symbol (currently supporting `:http`, `:event_bridge`, and `:pub_sub`), a webhook path (the relative path for an http webhook) and a handler. This only needs to be done once when the app is started and we recommend doing this at the same time that you setup `ShopifyAPI::Context`. An example is shown below to register an http webhook:

```ruby
registration = ShopifyAPI::Webhooks::Registry.add_registration(topic: "orders/create", delivery_method: :http, handler: WebhookHandler) 
```

**Note**: The webhooks you register with Shopify are saved in the Shopify platform, but the local `ShopifyAPI::Webhooks::Registry` needs to be reloaded whenever your server restarts.

### EventBridge and PubSub Webhooks

You can also register webhooks for delivery to Amazon EventBridge or Google Cloud
Pub/Sub. In this case the `path` argument to
`Shopify.Webhooks.Registry.register` needs to be of a specific form.

For EventBridge, the `path` must be the [ARN of the partner event
source](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_EventSource.html).

For Pub/Sub, the `path` must be of the form
`pubsub://[PROJECT-ID]:[PUB-SUB-TOPIC-ID]`. For example, if you created a topic
with id `red` in the project `blue`, then the value of `path` would be
`pubsub://blue:red`.

When registering for an EventBridge or PubSub Webhook you do not need to specify a handler as this is only used for handling Http webhooks.

## Register a Webhook for a Shop
At any point that you have a session for a shop you can register to receive webhooks for that shop. We recommend registering for webhooks immediately after [OAuth](./oauth.md).

This can be done in one of two ways:

If you would like to register to receive webhooks for all topics you have added to the registry for a specific shop you can simply call:
```ruby
ShopifyAPI::Webhooks::Registry.register_all(session: shop_session)
```

This will return an Array of `ShopifyAPI::Webhooks::RegisterResult`s that have fields `topic`, `success`, and `body` which can be used to see which webhooks were successfully registered.

Or if you would like to register to receive webhooks for specific topics that have been added to the registry for a specific shop you can simply call `register` for any needed topics:
```ruby
ShopifyAPI::Webhooks::Registry.register(topic: "<specific-topic>", session: shop_session)
```

This will return a single `ShopifyAPI::Webhooks::RegisterResult`.

## Process a Webhook

To process an http webhook, you need to listen on the route(s) you provided during the Webhook registration process, then when the route is hit construct a `ShopifyAPI::Webhooks::Request` and call `ShopifyAPI::Webhooks::Registry.process`. This will verify the request did indeed come from Shopify and then call the specified handler for that webhook. An example in Rails is shown below:

```ruby
class WebhookController < ApplicationController
  def webhook
    ShopifyAPI::Webhooks::Registry.process(
      ShopifyAPI::Webhooks::WebhookRequest.new(raw_body: request.raw_post, headers: request.headers.to_h)
    )
    render json: {success: true}.to_json
  end
end
```
