# frozen_string_literal: true
module ShopifyAPI
  # Assets represent the files that comprise your theme.
  # There are different buckets which hold different kinds
  # of assets, each corresponding to one of the folders
  # within a theme's zip file: "layout", "templates",
  # "snippets", "assets", and "config". The full key of an
  # asset always starts with the bucket name, and the path
  # separator is a forward slash, like layout/theme.liquid
  # or assets/bg-body.gif.
  #
  # Initialize with a key:
  #   asset = ShopifyAPI::Asset.new(key: 'assets/special.css', theme_id: 12345)
  #
  # Find by key:
  #   asset = ShopifyAPI::Asset.find('assets/image.png', params: {theme_id: 12345})
  #
  # Get the text or binary value:
  #   asset.value # decodes from attachment attribute if necessary
  #
  # You can provide new data for assets in a few different ways:
  #
  #   * assign text data for the value directly:
  #       asset.value = "div.special {color:red;}"
  #
  #   * provide binary data for the value:
  #       asset.attach(File.read('image.png'))
  #
  #   * set a URL from which Shopify will fetch the value:
  #       asset.src = "http://mysite.com/image.png"
  #
  #   * set a source key of another of your assets from which
  #     the value will be copied:
  #       asset.source_key = "assets/another_image.png"
  class Asset < Base
    include DisablePrefixCheck

    self.primary_key = 'key'

    conditional_prefix :theme

    def self.element_path(_id, prefix_options = {}, query_options = nil) #:nodoc:
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}"
    end

    # find an asset by key:
    #   ShopifyAPI::Asset.find('layout/theme.liquid', params: { theme_id: 99 })
    def self.find(*args)
      if args[0].is_a?(Symbol)
        super
      else
        params = { asset: { key: args[0] } }
        params = params.merge(args[1][:params]) if args[1] && args[1][:params]
        path_prefix = params[:theme_id] ? "themes/#{params[:theme_id]}/" : ""
        resource = find(
          :one,
          from: api_version.construct_api_path("#{path_prefix}assets.#{format.extension}"),
          params: params
        )
        resource.prefix_options[:theme_id] = params[:theme_id] if resource && params[:theme_id]
        resource
      end
    end

    # For text assets, Shopify returns the data in the 'value' attribute.
    # For binary assets, the data is base-64-encoded and returned in the
    # 'attachment' attribute. This accessor returns the data in both cases.
    def value
      attributes['value'] ||
      (attributes['attachment'] ? Base64.decode64(attributes['attachment']) : nil)
    end

    def attach(data)
      self.attachment = Base64.encode64(data)
    end

    def destroy
      connection.delete(element_path(prefix_options.merge(asset: { key: key })), self.class.headers)
    end

    def new?
      false
    end

    def method_missing(method_symbol, *arguments) #:nodoc:
      if %w{value= attachment= src= source_key=}.include?(method_symbol)
        wipe_value_attributes
      end
      super
    end

    private

    def wipe_value_attributes
      %w{value attachment src source_key}.each do |attr|
        attributes.delete(attr)
      end
    end
  end
end
