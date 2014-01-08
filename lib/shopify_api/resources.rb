require 'shopify_api/resources/base'
Dir.glob("#{File.dirname(__FILE__)}/resources/*").each { |file| require(file) } 
