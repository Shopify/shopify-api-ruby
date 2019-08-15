# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  test "coerce_to_version returns any version object given" do
    version = ShopifyAPI::ApiVersion.new(handle: :unstable)
    assert_same(version, ShopifyAPI::ApiVersion.coerce_to_version(version))
  end

  test "coerce_to_version converts a known version into a version object" do
    versions = [
      ShopifyAPI::ApiVersion.new(handle: :unstable),
      ShopifyAPI::ApiVersion.new(handle: '2019-01'),
    ]

    assert_equal(versions, [
      ShopifyAPI::ApiVersion.coerce_to_version('unstable'),
      ShopifyAPI::ApiVersion.coerce_to_version('2019-01'),
    ])
  end

  test "coerce_to_version removes unverified versions from version set if mode is set to :predefined_only" do
    ShopifyAPI::ApiVersion.coercion_mode = :define_on_unknown
    assert ShopifyAPI::ApiVersion.versions.values.all?(&:verified?)
    assert_equal 5, ShopifyAPI::ApiVersion.versions.size

    ShopifyAPI::ApiVersion.coerce_to_version('2019-30')
    refute ShopifyAPI::ApiVersion.versions.values.all?(&:verified?)
    assert_equal 6, ShopifyAPI::ApiVersion.versions.size
    ShopifyAPI::ApiVersion.coercion_mode = :predefined_only

    assert ShopifyAPI::ApiVersion.versions.values.all?(&:verified?)
    assert_equal 5, ShopifyAPI::ApiVersion.versions.size
  end

  test "coerce_to_version does not raise when coercing a string if no versions are defined when coercion_mode is :define_on_unknown" do
    ShopifyAPI::ApiVersion.clear_defined_versions
    ShopifyAPI::ApiVersion.coercion_mode = :define_on_unknown
    assert_equal :define_on_unknown, ShopifyAPI::ApiVersion.coercion_mode
    assert_nothing_raised do
      ShopifyAPI::ApiVersion.coerce_to_version('made up version')
    end
  end

  test "coerce_to_version does raise when coercing a string if no versions are defined when coercion_mode is :predefined_only" do
    refute ShopifyAPI::ApiVersion.versions['made up version']
    ShopifyAPI::ApiVersion.coercion_mode = :predefined_only
    assert_raises ShopifyAPI::ApiVersion::UnknownVersion do
      ShopifyAPI::ApiVersion.coerce_to_version('made up version')
    end
  end

  test 'two versions with the same version number are equal' do
    version_1 = ShopifyAPI::ApiVersion.new(handle: '2018-09')
    version_2 = ShopifyAPI::ApiVersion.new(handle: '2018-09')

    assert_equal version_2, version_1
  end

  test 'two versions with the different version numbers are not equal' do
    version_1 = ShopifyAPI::ApiVersion.new(handle: '2019-07')
    version_2 = ShopifyAPI::ApiVersion.new(handle: '2019-11')

    refute_equal version_2, version_1
  end

  test 'versions are ordered by version number with unstable always being the newest' do
    version_1 = ShopifyAPI::ApiVersion.new(handle: '2017-11')
    version_2 = ShopifyAPI::ApiVersion.new(handle: '2019-11')
    version_3 = ShopifyAPI::ApiVersion.new(handle: '2039-01')
    version_4 = ShopifyAPI::ApiVersion.new(handle: '2039-02')
    unstable = ShopifyAPI::ApiVersion.new(handle: :unstable)

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
    assert_equal(
      ShopifyAPI::ApiVersion.versions,
      {
        "2019-01" => ShopifyAPI::ApiVersion.new(handle: '2019-01', supported: true, latest_supported: false),
        "2019-04" => ShopifyAPI::ApiVersion.new(handle: '2019-04', supported: true, latest_supported: false),
        "2019-07" => ShopifyAPI::ApiVersion.new(handle: '2019-07', supported: true, latest_supported: true),
        "2019-10" => ShopifyAPI::ApiVersion.new(handle: '2019-10', supported: false, latest_supported: false),
        "unstable" => ShopifyAPI::ApiVersion.new(handle: 'unstable', supported: false, latest_supported: false),
      }
    )
    silence_warnings do

      refute_equal(
        ShopifyAPI::ApiVersion.new(handle: '2019-01'),
        ShopifyAPI::ApiVersion.latest_stable_version
      )

      assert_equal(
        ShopifyAPI::ApiVersion.new(handle: '2019-07'),
        ShopifyAPI::ApiVersion.latest_stable_version
      )
    end
  end

  test "handle_to_date converts a version handle to a date" do
    version_1 = ShopifyAPI::ApiVersion.new(handle: '2019-01')
    version_2 = ShopifyAPI::ApiVersion.new(handle: 'unstable')

    assert_equal(version_1.handle_as_date, Time.utc(2019, 01, 01))
    assert_equal(version_2.handle_as_date, ShopifyAPI::ApiVersion::UNSTABLE_AS_DATE)
  end
end
