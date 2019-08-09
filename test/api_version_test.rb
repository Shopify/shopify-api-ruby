# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  def teardown
    super
    ShopifyAPI::ApiVersion.clear_defined_versions
    ShopifyAPI::ApiVersion.coercion_mode = :define_on_unknown
    ShopifyAPI::ApiVersion.define_known_versions
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

  test "defined_only coerce_to_version converts a known version into a version object" do
    with_defined_only_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions


    versions = [
      ShopifyAPI::ApiVersion::Unstable.new,
      ShopifyAPI::ApiVersion::Release.new('2019-01'),
    ]

    versions.each do |version|
      ShopifyAPI::ApiVersion.define_version(version)
    end

    assert_equal(versions, [
      ShopifyAPI::ApiVersion.coerce_to_version('unstable'),
      ShopifyAPI::ApiVersion.coerce_to_version('2019-01'),
    ])
  end

  test "defined_only coerce_to_version raises when coercing a string that doesn't match a known version" do
    with_defined_only_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions

    assert_raises ShopifyAPI::VersionCoercers::UnknownVersion do
      ShopifyAPI::ApiVersion.coerce_to_version('made up version')
    end
  end

  test "defined_only additional defined versions will also be coerced" do
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

  test "define_on_unknown coerce_to_version converts any valid version string into a version object" do
    with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions

    versions = [
      ShopifyAPI::ApiVersion::Release.new('2030-02'),
      ShopifyAPI::ApiVersion::Release.new('2033-02'),
    ]

    assert_equal(versions, [
      ShopifyAPI::ApiVersion.coerce_to_version('2030-02'),
      ShopifyAPI::ApiVersion.coerce_to_version('2033-02'),
    ])
  end

  test "define_on_unknown coerce_to_version finds any defined version" do
    with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions

    defined_version = TestApiVersion.new('other_name')
    ShopifyAPI::ApiVersion.define_version(defined_version)

    coerced_version = ShopifyAPI::ApiVersion.coerce_to_version('other_name')

    assert_equal(defined_version, coerced_version)
  end

  test "define_on_unknown coerce_to_version defines a new version when coercing a string that doesn't match a known version" do
    with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions

    undefined_version = ShopifyAPI::ApiVersion::Release.new('2030-01')

    coerced_version = ShopifyAPI::ApiVersion.coerce_to_version('2030-01')
    second_coerced_version = ShopifyAPI::ApiVersion.coerce_to_version('2030-01')

    assert_equal(undefined_version, coerced_version)
    assert_same(second_coerced_version, coerced_version)
  end

  test "define_on_unknown coerce_to_version fails for unknown version that is not valid release version name" do
    with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.clear_defined_versions

    assert_raises ShopifyAPI::ApiVersion::InvalidVersion do
      ShopifyAPI::ApiVersion.coerce_to_version('this is not right')
    end
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

  test 'latest_stable_version will return the version that is newest and stable' do
    ShopifyAPI::ApiVersion.clear_defined_versions
    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2017-11'))
    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2019-11'))
    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2039-01'))
    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2039-02'))
    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Unstable.new)

    assert_equal(
      ShopifyAPI::ApiVersion::Release.new('2039-02'),
      ShopifyAPI::ApiVersion.latest_stable_version
    )
  end

  def with_defined_only_coercion
    ShopifyAPI::ApiVersion.coercion_mode = :defined_only
  end

  def with_define_on_unknown_coercion
    ShopifyAPI::ApiVersion.coercion_mode = :define_on_unknown
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
