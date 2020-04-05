require 'rubygems'
require 'minitest/autorun'
require 'webmock/minitest'
require_relative 'lib/webmock_extensions/last_request'
require 'mocha/minitest'
require 'pry'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

WebMock.disable_net_connect!
require 'shopify_api'

# setup ShopifyAPI with fake api_key and secret
module Test
  module Unit
    class TestCase < Minitest::Test
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

        ShopifyAPI::Base.clear_session

        fake("apis",
              url: "https://app.shopify.com/services/apis.json",
              method: :get,
              status: 200,
              api_version: :stub,
              body: load_fixture('apis'))

        ShopifyAPI::ApiVersion.fetch_known_versions
        session = ShopifyAPI::Session.new(
          domain: "https://this-is-my-test-shop.myshopify.com",
          token: "token_test_helper",
          api_version: '2019-01',
        )

        ShopifyAPI::Base.activate_session(session)
      end

      def teardown
        ShopifyAPI::Base.clear_session
        ShopifyAPI::Base.site = nil
        ShopifyAPI::Base.password = nil
        ShopifyAPI::Base.user = nil

        ShopifyAPI::ApiVersion.clear_known_versions
        ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown
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
        assert_equal expected, WebMock.last_request.body
      end

      def fake(endpoint, options={})
        request_body = options.has_key?(:request_body) ? options.delete(:request_body) : nil
        body   = options.has_key?(:body) ? options.delete(:body) : load_fixture(endpoint)
        format = options.delete(:format) || :json
        method = options.delete(:method) || :get
        api_version = options.delete(:api_version) || ShopifyAPI::ApiVersion.find_version('2019-01')
        extension = ".#{options.delete(:extension)||'json'}" unless options[:extension]==false
        status = options.delete(:status) || 200
        url = if options.has_key?(:url)
          options[:url]
        else
          "https://this-is-my-test-shop.myshopify.com#{api_version.construct_api_path("#{endpoint}#{extension}")}"
        end

        stubbing = WebMock.stub_request(method, url)
        stubbing = stubbing.with(body: request_body) if request_body
        stubbing.to_return(
          body: body, status: status, headers: { content_type: "text/#{format}", content_length: 1 }.merge(options)
        )
      end

      def ar_version_before?(version_string)
        Gem::Version.new(ActiveResource::VERSION::STRING) < Gem::Version.new(version_string)
      end

      def ar_version_after?(version_string)
        Gem::Version.new(version_string) < Gem::Version.new(ActiveResource::VERSION::STRING)
      end
    end
  end
end
