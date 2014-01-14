module ActiveResource
  class Base
    if ActiveResource::VERSION::MAJOR < 4
      # Backported from ActiveResource master branch
      def self.headers
        @headers ||= {}

        if superclass != Object && superclass.headers
          @headers = superclass.headers.merge(@headers)
        else
          @headers
        end
      end

      # https://github.com/rails/activeresource/commit/dfef85ce8f653f75673631b2950fcdb0781c313c
      def self.delete(id, options = {})
        connection.delete(element_path(id, options), headers)
      end
    end

    def self.build(attributes = {})
      attrs = self.format.decode(connection.get("#{new_element_path}", headers).body).merge(attributes)
      self.new(attrs)
    end
  end
end
