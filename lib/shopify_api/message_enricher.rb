# frozen_string_literal: true
module ShopifyAPI
  class MessageEnricher < SimpleDelegator
    def message
      return super unless (400...500).include?(code.to_i)

      @_cached_message ||= begin
        detailed_error =
          begin
            parsed_body = JSON.parse(body)

            if parsed_body['error']
              parsed_body['error'].to_s
            elsif parsed_body['errors']
              Array(parsed_body['errors']).join('; ')
            end
          rescue JSON::ParserError
            nil
          end

        detailed_error.present? ? "#{super} (#{detailed_error})" : super
      end
    end
  end
end
