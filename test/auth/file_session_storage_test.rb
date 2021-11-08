# typed: false
# frozen_string_literal: true

require_relative "../test_helper"
require "fakefs/safe"

class FileSessionStorageTest < Test::Unit::TestCase
  include TestHelpers::SessionStorage

  def setup
    ::FakeFS.activate!
    @storage = ShopifyAPI::Auth::FileSessionStorage.new
  end

  def teardown
    ::FakeFS.deactivate!
  end
end
