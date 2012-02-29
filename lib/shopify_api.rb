require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'active_resource/connection_ext'
require 'shopify_api/limits'

module ShopifyAPI
  include Limits
  VERSION = "1.2.5"
  
  METAFIELD_ENABLED_CLASSES = %w( Order Product CustomCollection SmartCollection Page Blog Article Variant)
  EVENT_ENABLED_CLASSES = %w( Order Product CustomCollection SmartCollection Page Blog Article )

  module Countable
    def count(options = {})
      Integer(get(:count, options))
    end
  end
  
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false

    def self.inherited(klass)
      super
      klass.headers['User-Agent'] = Base.headers['User-Agent']
    end
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
  
  ignore_files = ['cli.rb']
  Dir[File.join(File.dirname(__FILE__), 'shopify_api', '**/*.rb')].each do |file|
    require file unless ignore_files.include?(File.basename(file))
  end
  
  # Include Metafields module in all enabled classes
  METAFIELD_ENABLED_CLASSES.each do |klass|
    "ShopifyAPI::#{klass}".constantize.send(:include, Metafields)
  end
  
  # Include Events module in all enabled classes
  EVENT_ENABLED_CLASSES.each do |klass|
    "ShopifyAPI::#{klass}".constantize.send(:include, Events)
  end
  
end
