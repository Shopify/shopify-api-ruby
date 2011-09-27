$:.unshift File.dirname(__FILE__)

require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'active_resource/connection_ext'
require 'shopify_api/limits'
require 'shopify_api/json_format'
require 'active_resource/json_errors'

module ShopifyAPI
  include Limits
end

require 'shopify_api/events'
require 'shopify_api/metafields'
require 'shopify_api/countable'
require 'shopify_api/resources'
require 'shopify_api/session'
