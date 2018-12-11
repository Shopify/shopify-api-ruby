# frozen_string_literal: true

require 'test_helper'

class PingMessageTest < Test::Unit::TestCase
  def test_create_message
    fake("api/ping-api/v1/conversations/123/messages",
      method: :post,
      body: load_fixture('ping/message'))

    message = ShopifyAPI::Ping::Message.new(
      dedupe_key: SecureRandom.uuid,
      content: {
        text: "Hello from shopify_api",
      },
      sender_id: 'test',
      conversation_id: '123',
    )

    message.save
    assert_equal("d0c7a2e6-8084-4e79-8483-e4a1352b81f7", message.id)
  end
end
