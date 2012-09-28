module ActiveResource
  if ActiveResource::VERSION::STRING =~ /^3\.0\./
    module Formats
      module JsonFormat
        def decode(json)
          data = ActiveSupport::JSON.decode(json)
          if data.is_a?(Hash) && data.keys.size == 1
            data.values.first
          else
            data
          end
        end
      end
    end
  end
end