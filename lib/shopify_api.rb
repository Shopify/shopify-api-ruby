# frozen_string_literal: true
$:.unshift(File.dirname(__FILE__))
require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'active_resource/detailed_log_subscriber'
require 'active_resource/json_errors'

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.6")
  puts("\nshopify_api: NOTE: Support for Ruby #{RUBY_VERSION} will be dropped in the next major release. Please update to Ruby 2.6 or newer before updating this gem.\n\n")
end

module ShopifyAPI
  extend ActiveSupport::Autoload

  require 'shopify_api/limits'
  require 'shopify_api/api_version'
  require 'shopify_api/paginated_collection'
  require 'shopify_api/disable_prefix_check'
  require 'shopify_api/events'
  require 'shopify_api/metafields'
  require 'shopify_api/countable'
  require 'shopify_api/resources'
  require 'shopify_api/session'
  require 'shopify_api/hmac_params'
  require 'shopify_api/api_access'
  require 'shopify_api/message_enricher'
  require 'shopify_api/connection'
  require 'shopify_api/pagination_link_headers'
  require 'shopify_api/graphql'

  eager_autoload do
    autoload(:Meta)
  end

  include Limits
end

require 'shopify_api/graphql/railtie' if defined?(Rails)

if ENV["SHOPIFY_LOG_PATH"]
  ActiveResource::Base.logger = Logger.new(ENV["SHOPIFY_LOG_PATH"])
  ActiveResource::DetailedLogSubscriber.attach_to(:active_resource_detailed)
end
