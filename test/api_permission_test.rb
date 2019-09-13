# frozen_string_literal: true
require 'test_helper'

class ApiPermissionTest < Test::Unit::TestCase
  test "revoke access token" do
    fake "api_permissions/current", method: :delete, status: 200, body: "{}"
    assert ShopifyAPI::ApiPermission.destroy
  end
end
