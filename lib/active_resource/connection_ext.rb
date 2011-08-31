require 'active_support/core_ext/module/aliasing'

module ActiveResource
  class Connection
    
    attr_reader :response
    
    def handle_response_with_response_capture(response)
      @response = handle_response_without_response_capture(response)
    end
    
    alias_method_chain :handle_response, :response_capture
    # alias_method :handle_response_without_instance, :handle_response
    # alias_method :handle_response, :handle_response_with_instance
  end
end