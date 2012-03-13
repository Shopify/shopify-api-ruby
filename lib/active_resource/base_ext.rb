module ActiveResource
  class Base
    # Backported from ActiveResource master branch
    def self.headers
      @headers ||= {}

      if superclass != Object && superclass.headers
        @headers = superclass.headers.merge(@headers)
      else
        @headers
      end
    end
  end
end
