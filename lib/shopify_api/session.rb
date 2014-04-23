require 'shopify_api/session/temp'
require 'shopify_api/session/uri'
require 'shopify_api/session/oauth'

module ShopifyAPI
  class Session
    attr_accessor :url, :name

    class << self
      def setup(params)
        params.each {|key, value| public_send("#{key}=", value) }
      end

      def prepare_url(url)
        return if url.blank?

        # remove http:// or https://
        url.gsub!(/https?:\/\//, '')

        # add myshopify.com to url if no host is given
        url.concat(".myshopify.com") unless url.include?('.')
      end

      def host_with_port(site)
        site = URI.parse(site)
        host = site.host or return
        port = site.port
        protocol_port = { 'http' => 80, 'https' => 443 }[protocol]
        port == protocol_port ? host : "#{host}:#{port}"
      end
    end

    def initialize(url, token = nil)
      self.url, self.token = url, token
      self.class.prepare_url(self.url)
    end

    def shop
      Shop.current
    end

    def site
      "#{protocol}://#{url}/admin"
    end

    def valid?
      url.present? && token.present?
    end
  end
end
