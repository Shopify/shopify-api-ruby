# frozen_string_literal: true
require 'test_helper'

class MessageEnricherTest < Test::Unit::TestCase
  def test_enriches_initial_message_when_body_contains_error
    response = enriched_response(422, 'InitialMessage', { error: 'My Error' })

    assert_equal('InitialMessage (My Error)', response.message)
  end

  def test_enriches_initial_message_when_body_contains_errors_array
    response = enriched_response(422, 'InitialMessage', { errors: ['My Error1', 'My Error2'] })

    assert_equal('InitialMessage (My Error1; My Error2)', response.message)
  end

  def test_enriches_initial_message_when_body_contains_errors_single_value
    response = enriched_response(422, 'InitialMessage', { errors: 'My Error1' })

    assert_equal('InitialMessage (My Error1)', response.message)
  end

  def test_returns_initial_message_when_code_is_200
    response = enriched_response(200, 'InitialMessage', { result: 'Success' })

    assert_equal('InitialMessage', response.message)
  end

  def test_returns_initial_message_when_body_cant_be_parsed
    response = enriched_response(422, 'InitialMessage', 'not a json')

    assert_equal('InitialMessage', response.message)
  end

  private

  def enriched_response(code, message, body)
    mock_response =
      Struct
        .new(:code, :message, :body)
        .new(code.to_s, message.to_s, body.to_json)

    ShopifyAPI::MessageEnricher.new(mock_response)
  end
end
