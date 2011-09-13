module ActiveResource
  class Base
    def encode(options = {})
      same = dup
      same.attributes = {self.class.element_name => same.attributes} if self.class.format.extension == 'json'

      same.send("to_#{self.class.format.extension}", options)
    end
  end

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
