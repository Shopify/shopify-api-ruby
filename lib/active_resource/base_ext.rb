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

      def self.build(attributes = {})
        attrs = self.format.decode(connection.get("#{new_element_path}", headers).body).merge(attributes)
        self.new(attrs)
      end
    end

    if ActiveResource::VERSION::MAJOR >= 4
      # can remove this clause when https://github.com/peterjm/activeresource/commit/1d166614f0103df7a972ea80aff11ff5a32e71ad is merged
      def self.build(attributes = {})
        attrs = self.format.decode(connection.get("#{new_element_path(attributes)}", headers).body).merge(attributes)
        self.new(attrs)
      end
    end
  end
end
