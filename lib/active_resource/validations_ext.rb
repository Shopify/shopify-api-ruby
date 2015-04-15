module ActiveResource
  module Validations
    def self.included(base)
      base.class_eval do
        alias_method_chain :save, :bad_request_handling
      end
    end

    def save_with_bad_request_handling(options={})
      save_without_bad_request_handling
    rescue BadRequest => error
      @remote_errors = error
      load_remote_errors(@remote_errors, true)

      raise
    end
  end
end
