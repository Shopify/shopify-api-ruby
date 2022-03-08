# typed: strict
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require "oj"
require "sorbet-runtime"
require "securerandom"
require "cgi"
require "uri"
require "openssl"
require "httparty"
require "zeitwerk"
require "jwt"
require "concurrent"

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.6")
  puts("\nshopify_api: NOTE: Support for Ruby #{RUBY_VERSION} will be dropped in the next major release. Please update to Ruby 2.6 or newer before updating this gem.\n\n")
end

require_relative "shopify_api/inflector"
require_relative "shopify_api/admin_versions"

loader = Zeitwerk::Loader.for_gem
loader.inflector = ShopifyAPI::Inflector.new(__FILE__)
loader.ignore("#{__dir__}/shopify_api/rest/resources")
loader.setup
