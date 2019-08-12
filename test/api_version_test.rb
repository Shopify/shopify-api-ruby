# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  def teardown
    super
    ShopifyAPI::ApiVersion.coercer = ShopifyAPI::VersionCoercers::GenerateRelease.new
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

  test "coerce_to_version delgates to declared version coercer" do
    fake_version = TestApiVersion.new('from fake coercer')

    fake_coercer = Class.new do
      def coerce_to_version(version_name)
        TestApiVersion.new('from fake coercer')
      end
    end

    ShopifyAPI::ApiVersion.coercer = fake_coercer.new

    assert_equal(fake_version, ShopifyAPI::ApiVersion.coerce_to_version('anything'))
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

  test 'release verions are stable' do
    assert_predicate ShopifyAPI::ApiVersion::Release.new('2019-11'), :stable?
  end

  test 'no release version are not stable' do
    refute_predicate ShopifyAPI::ApiVersion::Unstable.new, :stable?
  end

  test 'release versions are ordered by version number with unstable always being the newest' do
    version_1 = ShopifyAPI::ApiVersion::Release.new('2017-11')
    version_2 = ShopifyAPI::ApiVersion::Release.new('2019-11')
    version_3 = ShopifyAPI::ApiVersion::Release.new('2039-01')
    version_4 = ShopifyAPI::ApiVersion::Release.new('2039-02')
    unstable = ShopifyAPI::ApiVersion::Unstable.new

    assert_equal([
      version_1,
      version_2,
      version_3,
      version_4,
      unstable,
    ], [
      version_3,
      version_1,
      version_4,
      unstable,
      version_2,
    ].sort)
  end

  def with_defined_only_coercion
    ShopifyAPI::ApiVersion.coercer = ShopifyAPI::VersionCoercers::DefinedOnly.new
  end

  def with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.coercer = ShopifyAPI::VersionCoercers::GenerateRelease.new
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
