module ShopifyAPI
  # avoid removing the root key as it is being used internally by ActiveResource::Base#load_from_response
  # https://github.com/rails/activeresource/blob/master/lib/active_resource/formats/json_format.rb#L21
  module VaultSessionFormat
    extend self

    def extension
      "json"
    end

    def mime_type
      "application/json"
    end

    def encode(hash, options = nil)
      ActiveSupport::JSON.encode(hash, options)
    end

    def decode(json)
      ActiveSupport::JSON.decode(json)
    end
  end
end
