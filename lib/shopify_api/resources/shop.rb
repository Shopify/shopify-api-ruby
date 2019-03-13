module ShopifyAPI
  # Shop object. Use Shop.current to receive
  # the shop.
  class Shop < Base
    if ActiveResource::VERSION::MAJOR >= 4
      include ActiveResource::Singleton

      def self.current(options = {})
        find(options)
      end
    else
      def self.current(options = {})
        find(:one, options.merge(from: "#{api_prefix}shop.#{format.extension}"))
      end
    end

    def metafields(**options)
      Metafield.find :all, params: options
    end

    def add_metafield(metafield)
      raise ArgumentError, "You can only add metafields to resource that has been saved" if new?
      metafield.save
      metafield
    end

    def events
      Event.find(:all)
    end
  end
end
