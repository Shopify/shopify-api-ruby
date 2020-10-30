# frozen_string_literal: true
require 'test_helper'

class UserTest < Test::Unit::TestCase
  test 'get should get a user' do
    fake 'users/799407056', method: :get, status: 200, body: load_fixture('user')

    user = ShopifyAPI::User.find(799407056)
    assert_equal 799407056, user.id
  end

  test 'get should get all users' do
    fake 'users', method: :get, status: 200, body: load_fixture('users')

    users = ShopifyAPI::User.all
    assert_equal 799407056, users.first.id
  end
end
