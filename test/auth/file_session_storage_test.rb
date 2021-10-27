# typed: false
# frozen_string_literal: true

require_relative "./session_storage_test_helper"
require "fakefs/safe"

class FileSessionStorageTest < Minitest::Test
  include SessionStorageTestHelper
  def setup
    FakeFS.activate!
    @storage = ShopifyAPI::Auth::FileSessionStorage.new
  end
end
