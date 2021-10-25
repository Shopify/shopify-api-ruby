# typed: strict

module ShopifyAPI
  class Context
    extend T::Sig

    @@api_key = T.let(nil, T.nilable(String))
    @@api_secret_key = T.let(nil, T.nilable(String))
    @@host_name = T.let(nil, T.nilable(String))

    sig do 
      params(
        api_key: String,
        api_secret_key: String,
        host_name: T.nilable(String)
      ).void
    end
    def self.setup(api_key:, api_secret_key:, host_name: nil)
      @@api_key = api_key
      @@api_secret_key = api_secret_key
      @@host_name = host_name
    end

    sig { returns(T.nilable(String)) }
    def self.api_key
      @@api_key
    end

    sig { returns(T.nilable(String)) }
    def self.api_secret_key
      @@api_secret_key
    end

    sig { returns(T.nilable(String)) }
    def self.host_name
      @@host_name
    end
  end
end
