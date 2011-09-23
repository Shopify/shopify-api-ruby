require 'active_resource/base'

module ActiveResource
  class Errors < ActiveModel::Errors
    def from_hash(messages, save_cache = false)
      clear unless save_cache

      messages.each do |key,errors|
        errors.each do |error|
          add(key, error)
        end
      end
    end

    # Grabs errors from a json response.
    def from_json(json, save_cache = false)
      hash = ActiveSupport::JSON.decode(json)['errors'] || {} rescue {}
      from_hash hash, save_cache
    end
  end
end
