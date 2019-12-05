module ShopifyAPI
  class MessageEnricher < SimpleDelegator
    def message
      return super unless (400...500).include?(code.to_i)

      @_cached_message ||= begin
        detailed_error = begin
          JSON.parse(body)['error'].to_s
        rescue JSON::ParserError
          nil
        end

        detailed_error.present? ? "#{super} (#{detailed_error})" : super
      end
    end
  end
end
