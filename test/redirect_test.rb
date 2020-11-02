# frozen_string_literal: true
require 'test_helper'

class RedirectTest < Test::Unit::TestCase
  test "#create should create a redirect" do
    fake("redirects", method: :post, status: 201, body: load_fixture('redirect'))
    redirect = ShopifyAPI::Redirect.create(path: "/ipod", target: "/pages/itunes")
    assert_equal(979034150, redirect.id)
  end
end
