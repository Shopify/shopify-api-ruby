# frozen_string_literal: true
require 'shopify_api/resources/base'
require 'shopify_api/resources/array_base'
Dir.glob("#{File.dirname(__FILE__)}/resources/**/*.rb").each do |file|
  require(file)
end
