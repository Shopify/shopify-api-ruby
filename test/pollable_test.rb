require "test_helper"

class MockedPollable < ShopifyAPI::Base
  include Pollable
  self.max_retries = 3
  self.interval = 100

  def self.element_url(id, *args)
    "#{site}#{element_path(id, *args)}"
  end
end

class PollableTest < Test::Unit::TestCase
  def test_poll
    fake "mock_a", method: :get, status: 202, body: {}.to_json,
      headers: { "Location" => MockedPollable.element_url("mock_b") }
    fake "mock_b", method: :get, status: 202, body: {}.to_json,
      headers: { "Location" => MockedPollable.element_url("mock_c") }
    fake "mock_c", method: :get, status: 200, body: {"alain" => "proviste"}.to_json,

    mocked_pollable = MockedPollable.find("mock_a")
    assert_equal "proviste", mocked_pollable.alain
  end
end
