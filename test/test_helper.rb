require 'rubygems'
require 'minitest/autorun'
require 'fakeweb'
require 'mocha/setup'
require 'pry'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'shopify_api'

FakeWeb.allow_net_connect = false

# setup ShopifyAPI with fake api_key and secret
module Test
  module Unit
  end
end

class Test::Unit::TestCase < Minitest::Unit::TestCase
  def self.test(string, &block)
    define_method("test_#{string}", &block)
  end

  def self.should(string, &block)
    self.test("should_#{string}", &block)
  end

  def self.context(string)
    yield
  end

  def setup
    ActiveResource::Base.format = :json
    ShopifyAPI.constants.each do |const|
      begin
        const = mod.const_get(const)
        const.format = :json if const.respond_to?(:format=)
      rescue NameError
      end
    end

    ShopifyAPI::ApiVersion.define_version(ShopifyAPI::ApiVersion::Release.new('2019-01'))

    ShopifyAPI::Base.clear_session
    session = ShopifyAPI::Session.new(
      domain: "https://this-is-my-test-shop.myshopify.com",
      token: "token_test_helper",
      api_version: '2019-01',
    )

    ShopifyAPI::Base.activate_session(session)
  end

  def teardown
    FakeWeb.clean_registry

    ShopifyAPI::Base.clear_session
    ShopifyAPI::Base.site = nil
    ShopifyAPI::Base.password = nil
    ShopifyAPI::Base.user = nil

    ShopifyAPI::ApiVersion.clear_defined_versions
    ShopifyAPI::ApiVersion.define_known_versions
  end

  # Custom Assertions
  def assert_not(expression)
    refute expression, "Expected <#{expression}> to be false!"
  end

  def assert_nothing_raised
    yield
  end

  def assert_not_includes(array, value)
    refute array.include?(value)
  end

  def assert_includes(array, value)
    assert array.include?(value)
  end

  def load_fixture(name, format=:json)
    File.read(File.dirname(__FILE__) + "/fixtures/#{name}.#{format}")
  end

  def assert_request_body(expected)
    assert_equal expected, FakeWeb.last_request.body
  end

  def fake(endpoint, options={})
    body   = options.has_key?(:body) ? options.delete(:body) : load_fixture(endpoint)
    format = options.delete(:format) || :json
    method = options.delete(:method) || :get
    api_version = options.delete(:api_version) || ShopifyAPI::ApiVersion.coerce_to_version('2019-01')
    extension = ".#{options.delete(:extension)||'json'}" unless options[:extension]==false

    url = if options.has_key?(:url)
      options[:url]
    else
      "https://this-is-my-test-shop.myshopify.com#{api_version.construct_api_path("#{endpoint}#{extension}")}"
    end

    FakeWeb.register_uri(method, url, {:body => body, :status => 200, :content_type => "text/#{format}", :content_length => 1}.merge(options))
  end

  def ar_version_before?(version_string)
    Gem::Version.new(ActiveResource::VERSION::STRING) < Gem::Version.new(version_string)
  end

  def ar_version_after?(version_string)
    Gem::Version.new(version_string) < Gem::Version.new(ActiveResource::VERSION::STRING)
  end
end
