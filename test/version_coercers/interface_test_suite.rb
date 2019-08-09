# frozen_string_literal: true
module VersionCoercersInterfaceTestSuite

  def self.test(string, &block)
    define_method("test_#{string}", &block)
  end

  test "coerce_to_version returns any version object given without a lookup" do
    version = ShopifyAPI::ApiVersion::Unstable.new
    assert_same(version, @coercer.coerce_to_version(version))
  end

  test "alls defined versions are available form known_versions" do
    versions = [
      TestApiVersion.new('my_name'),
      TestApiVersion.new('other_name'),
    ]

    versions.each do |version|
      @coercer.define_version(version)
    end

    assert_equal(versions, @coercer.known_versions)
  end

  test "clear_defined_versions removes all known versions" do
    versions = [
      TestApiVersion.new('my_name'),
      TestApiVersion.new('other_name'),
    ]

    versions.each do |version|
      @coercer.define_version(version)
    end

    @coercer.clear_defined_versions

    assert_predicate(@coercer.known_versions, :empty?)
  end

  class TestApiVersion < ShopifyAPI::ApiVersion
    def initialize(name)
      @version_name = name
    end
  end
end
