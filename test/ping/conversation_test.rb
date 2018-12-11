# frozen_string_literal: true

require 'test_helper'

class PingConversationTest < Test::Unit::TestCase
  def test_create_conversation
    fake "api/ping-api/v1/conversations", method: :post, body: load_fixture('ping/conversation')

    conversation = ShopifyAPI::Ping::Conversation.new(
      topic: 'my topic',
      participants: [
        {
          name: 'foo',
          id: 'test',
          group: 'customer',
        },
      ]
    )

    conversation.save

    assert_equal "d315d4f7-53bd-49ec-8808-23f6db3c641a", conversation.id
  end

  def test_send_message
    fake "api/ping-api/v1/conversations/123/messages", method: :post, body: load_fixture('ping/message')

    conversation = ShopifyAPI::Ping::Conversation.new(id: '123')
    message = conversation.send_message(
      dedupe_key: SecureRandom.uuid,
      content: {
        text: "Hello from shopify_api",
      },
      sender_id: 'test',
    )

    assert_equal "d0c7a2e6-8084-4e79-8483-e4a1352b81f7", message.id
  end

  def test_successful_delivery
    fake("api/ping-api/v1/conversations/123/messages/111/delivery_confirmation",
      method: :post,
      body: load_fixture('ping/successful_delivery_confirmation'))

    conversation = ShopifyAPI::Ping::Conversation.new(id: '123')
    delivery_confirmation = conversation.successful_delivery(
      message_id: '111',
      delivery_timestamp: "2018-08-29T22:16:05.589479Z"
    )

    assert_equal("true", delivery_confirmation.delivered)
    assert_equal("2018-08-29T22:16:05.589479Z", delivery_confirmation.delivery_timestamp)
  end

  def test_failed_delivery
    fake("api/ping-api/v1/conversations/123/messages/111/delivery_confirmation",
      method: :post,
      body: load_fixture('ping/failed_delivery_confirmation'))

    conversation = ShopifyAPI::Ping::Conversation.new(id: '123')
    delivery_confirmation = conversation.failed_delivery(
      message_id: '111',
      delivery_timestamp: Time.now.to_s,
      details: "Integration failed to deliver message."
    )

    assert_equal("false", delivery_confirmation.delivered)
    assert_equal("2018-08-29T22:16:05.589479Z", delivery_confirmation.delivery_timestamp)
    assert_equal("Integration failed to deliver message.", delivery_confirmation.details)
  end
end
