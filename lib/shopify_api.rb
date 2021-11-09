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

require_relative "shopify_api/inflector"

loader = Zeitwerk::Loader.for_gem
loader.inflector = ShopifyAPI::Inflector.new(__FILE__)
loader.setup
