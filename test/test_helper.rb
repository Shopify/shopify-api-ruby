require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'shopify_api'

# setup ShopifyAPI with fake api_key and secret
ShopifyAPI::Session.setup(:api_key => "API Test key", :secret => "API Test secret")

class Test::Unit::TestCase
  # Custom Assertions
  def assert_not(expression)
    assert_block("Expected <#{expression}> to be false!") { not expression }
  end  
end
