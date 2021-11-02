# typed: strict
# frozen_string_literal: true

module TestHelpers
  class FakeSessionStorage
    extend T::Sig
    include ShopifyAPI::Auth::SessionStorage

    sig { returns(T::Hash[String, ShopifyAPI::Auth::Session]) }
    attr_reader :sessions

    sig { returns(T::Boolean) }
    attr_reader :error_on_save

    sig { params(sessions: T::Hash[String, ShopifyAPI::Auth::Session], error_on_save: T::Boolean).void }
    def initialize(sessions:, error_on_save:)
      @sessions = sessions
      @error_on_save = error_on_save
    end

    sig do
      override.params(session: ShopifyAPI::Auth::Session)
        .returns(T::Boolean)
    end
    def store_session(session)
      return false if error_on_save
      sessions[session.id] = session
      true
    end

    sig do
      override.params(id: String)
        .returns(T.nilable(ShopifyAPI::Auth::Session))
    end
    def load_session(id)
      sessions[id]
    end

    sig do
      override.params(id: String)
        .returns(T::Boolean)
    end
    def delete_session(id)
      sessions.delete(id)
      true
    end
  end
end
