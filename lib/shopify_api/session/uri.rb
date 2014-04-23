module ShopifyAPI
  class Session
    cattr_accessor :protocol

    self.protocol = 'https'

    private

    def https(path)
      u = uri.build(host: url, path: path)
      Net::HTTP.new(u.host, u.port).tap {|h| h.use_ssl = true }
    end

    def uri
      protocol == 'https' ? URI::HTTPS : URI::HTTP
    end
  end
end
