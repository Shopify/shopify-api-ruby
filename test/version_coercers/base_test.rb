# frozen_string_literal: true
require 'test_helper'
require_relative './interface_test_suite'

class VersionCoercersBaseTest < Test::Unit::TestCase
  include VersionCoercersInterfaceTestSuite

  def setup
    @coercer = ShopifyAPI::VersionCoercers::Base.new
  end

  test "coerce_to_version calls subclass method to coerce anything that isn't already a version" do
    assert_raises NotImplementedError do
      @coercer.coerce_to_version('unstable')
    end
  end
end
