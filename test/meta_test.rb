# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  test ".admin_versions returns array of api versions for admin" do
    versions = [
      {
        "handle": "2019-01",
        "display_name": "2019-01",
        "supported": true,
        "latest_supported": false
      },
      {
        "handle": "2019-04",
        "latest_supported": false,
        "display_name": "2019-04",
        "supported": true
      },
      {
        "handle": "2019-07",
        "latest_supported": false,
        "display_name": "2019-07",
        "supported": true
      },
      {
        "handle": "2019-10",
        "latest_supported": false,
        "display_name": "2019-10",
        "supported": true
      },
      {
        "handle": "2020-01",
        "latest_supported": true,
        "display_name": "2020-01 (Latest)",
        "supported": true
      },
      {
        "handle": "unstable",
        "latest_supported": false,
        "display_name": "unstable",
        "supported": false
      }
    ].to_json


    assert_equal versions, ShopifyAPI::Meta.admin_versions.to_json

  end
end
