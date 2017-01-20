require "test_helper"

class VaultSessionFormatTest < Test::Unit::TestCase
  def setup
    super
    @data = { "session_id" => "lemieux", "checkout" => { "email" => "bob@customer.com" } }
  end

  def test_extension_is_json
    assert_equal "json", ShopifyAPI::VaultSessionFormat.extension
  end

  def test_mime_type_is_application_json
    assert_equal "application/json", ShopifyAPI::VaultSessionFormat.mime_type
  end

  def test_encode_serializes_to_json
    assert_equal @data.to_json, ShopifyAPI::VaultSessionFormat.encode(@data)
  end

  def test_decode_deserializes_json_with_root_key
    assert_equal @data, ShopifyAPI::VaultSessionFormat.decode(@data.to_json)
  end
end
