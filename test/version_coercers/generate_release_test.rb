# frozen_string_literal: true
require 'test_helper'
require_relative './interface_test_suite'

class VersionCoercersGenerateReleaseTest < Test::Unit::TestCase
  include VersionCoercersInterfaceTestSuite

  def setup
    @coercer = ShopifyAPI::VersionCoercers::GenerateRelease.new
  end

  test "coerce_to_version converts a known version into a version object" do
    versions = [TestApiVersion.new('maded up')]

    versions.each do |version|
      @coercer.define_version(version)
    end

    assert_equal(versions, [
      @coercer.coerce_to_version('maded up'),
    ])
  end

  test "coerce_to_version converts any valid version string into a release version" do
    versions = [
      ShopifyAPI::ApiVersion::Release.new('2030-02'),
      ShopifyAPI::ApiVersion::Release.new('2033-02'),
    ]

    assert_equal(versions, [
      @coercer.coerce_to_version('2030-02'),
      @coercer.coerce_to_version('2033-02'),
    ])
  end

  test "coerce_to_version defines a new version when coercing a string that doesn't match a known version" do
    undefined_version = ShopifyAPI::ApiVersion::Release.new('2030-01')

    coerced_version = @coercer.coerce_to_version('2030-01')
    second_coerced_version = @coercer.coerce_to_version('2030-01')

    assert_equal(undefined_version, coerced_version)
    assert_same(second_coerced_version, coerced_version)
    assert_equal([undefined_version], @coercer.known_versions)
  end

  test "coerce_to_version defines unstable when the name is unstable" do
    undefined_version = ShopifyAPI::ApiVersion::Unstable.new

    coerced_version = @coercer.coerce_to_version('unstable')

    assert_equal(undefined_version, coerced_version)
    assert_equal([undefined_version], @coercer.known_versions)
  end

  test "coerce_to_version fails for unknown version that is not valid release version name" do
    assert_raises ShopifyAPI::ApiVersion::InvalidVersion do
      @coercer.coerce_to_version('this is not right')
    end
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
