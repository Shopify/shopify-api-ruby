# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  def teardown
    super
    ShopifyAPI::ApiVersion.clear_defined_versions
    ShopifyAPI::ApiVersion.define_known_versions
  end

  test "no version creates url that start with /admin/" do
    assert_equal(
      "/admin/resource_path/id.json",
      ShopifyAPI::ApiVersion::NoVersion.new.construct_api_path("resource_path/id.json")
    )
  end

  test "no version creates graphql url that start with /admin/api" do
    assert_equal(
      "/admin/api/graphql.json",
      ShopifyAPI::ApiVersion::NoVersion.new.construct_graphql_path
    )
  end

  test "unstable version creates url that start with /admin/api/unstable/" do
    assert_equal(
      "/admin/api/unstable/resource_path/id.json",
      ShopifyAPI::ApiVersion::Unstable.new.construct_api_path("resource_path/id.json")
    )
  end

  test "unstable version creates graphql url that start with /admin/api/unstable/" do
    assert_equal(
      "/admin/api/unstable/graphql.json",
      ShopifyAPI::ApiVersion::Unstable.new.construct_graphql_path
    )
  end

  test "coerce_to_version returns any version object given" do
    version = ShopifyAPI::ApiVersion::Unstable.new
    assert_same(version, ShopifyAPI::ApiVersion.coerce_to_version(version))
  end

  test "coerce_to_version converts a known version into a version object" do
    versions = [
      ShopifyAPI::ApiVersion::Unstable.new,
      ShopifyAPI::ApiVersion::NoVersion.new,
    ]

    assert_equal(versions, [
      ShopifyAPI::ApiVersion.coerce_to_version('unstable'),
      ShopifyAPI::ApiVersion.coerce_to_version(:no_version),
    ])
  end

  test "coerce_to_version raises when coercing a string that doesn't match a known version" do
    assert_raises ShopifyAPI::ApiVersion::UnknownVersion do
      ShopifyAPI::ApiVersion.coerce_to_version('made up version')
    end
  end

  test "additional defined versions will also be coerced" do
    versions = [
      TestApiVersion.new('my_name'),
      TestApiVersion.new('other_name'),
    ]

    versions.each do |version|
      ShopifyAPI::ApiVersion.define_version(version)
    end

    assert_equal(versions, [
      ShopifyAPI::ApiVersion.coerce_to_version('my_name'),
      ShopifyAPI::ApiVersion.coerce_to_version('other_name'),
    ])
  end

  test 'allows a release version with the correct format format to be created' do
    assert ShopifyAPI::ApiVersion::Release.new('2019-03')
  end

  test 'release versions must follow the format' do
    assert_raises ShopifyAPI::ApiVersion::InvalidVersion do
      assert ShopifyAPI::ApiVersion::Release.new('crazy-name')
    end
  end

  test 'release versions create a url that is /admin/api/<version_name>/' do
    assert_equal(
      '/admin/api/2022-03/shop.json',
      ShopifyAPI::ApiVersion::Release.new('2022-03').construct_api_path('shop.json')
    )
  end

  test 'two versions with the same version number are equal' do
    version_1 = ShopifyAPI::ApiVersion::Release.new('2018-09')
    version_2 = ShopifyAPI::ApiVersion::Release.new('2018-09')

    assert_equal version_2, version_1
  end

  test 'two versions with the different version numbers are not equal' do
    version_1 = ShopifyAPI::ApiVersion::Release.new('2019-07')
    version_2 = ShopifyAPI::ApiVersion::Release.new('2019-11')

    refute_equal version_2, version_1
  end

  test 'release versions are ordered by version number with unstable always being the newest and no version always being the oldest' do
    version_1 = ShopifyAPI::ApiVersion::Release.new('2017-11')
    version_2 = ShopifyAPI::ApiVersion::Release.new('2019-11')
    version_3 = ShopifyAPI::ApiVersion::Release.new('2039-01')
    version_4 = ShopifyAPI::ApiVersion::Release.new('2039-02')
    unstable = ShopifyAPI::ApiVersion::Unstable.new
    no_version = ShopifyAPI::ApiVersion::NoVersion.new

    assert_equal([
      no_version,
      version_1,
      version_2,
      version_3,
      version_4,
      unstable,
    ], [
      version_3,
      version_1,
      no_version,
      version_4,
      unstable,
      version_2,
    ].sort)
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
