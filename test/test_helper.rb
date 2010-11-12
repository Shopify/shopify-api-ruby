require 'rubygems'
require 'test/unit'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'shopify_api'

# setup ShopifyAPI with fake api_key and secret
ShopifyAPI::Session.setup(:api_key => "API Test key", :secret => "API Test secret")

class Test::Unit::TestCase
  def self.test(string, &block)
    define_method("test:#{string}", &block)
  end

  def self.should(string, &block)
    self.test("should_#{string}", &block)
  end
  
  def self.context(string)
    yield
  end
  
  # Custom Assertions
  def assert_not(expression)
    assert_block("Expected <#{expression}> to be false!") { not expression }
  end  
end
