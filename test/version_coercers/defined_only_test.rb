# frozen_string_literal: true
require 'test_helper'
require_relative './interface_test_suite'

class VersionCoercersDefinedOnlyTest < Test::Unit::TestCase
  include VersionCoercersInterfaceTestSuite

  def setup
    @coercer = ShopifyAPI::VersionCoercers::DefinedOnly.new
  end

  test "coerce_to_version converts a known version into a version object" do
    versions = [
      ShopifyAPI::ApiVersion::Unstable.new,
      ShopifyAPI::ApiVersion::Release.new('2019-01'),
    ]

    versions.each do |version|
      @coercer.define_version(version)
    end

    assert_equal(versions, [
      @coercer.coerce_to_version('unstable'),
      @coercer.coerce_to_version('2019-01'),
    ])
  end

  test "coerce_to_version raises when coercing a string that doesn't match a known version" do
    assert_raises ShopifyAPI::VersionCoercers::UnknownVersion do
      @coercer.coerce_to_version('made up version')
    end
  end

  test "any defined versions will also be coerced" do
    versions = [
      TestApiVersion.new('my_name'),
      TestApiVersion.new('other_name'),
    ]

    versions.each do |version|
      @coercer.define_version(version)
    end

    assert_equal(versions, [
      @coercer.coerce_to_version('my_name'),
      @coercer.coerce_to_version('other_name'),
    ])
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
