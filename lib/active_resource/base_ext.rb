module ActiveResource
  class Base
    def self.build(attributes = {})
      attrs = self.format.decode(connection.get("#{new_element_path(attributes)}", headers).body).merge(attributes)
      self.new(attrs)
    end
  end
end
