# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    class << self
      extend T::Sig

      sig do
        params(
          session: T.nilable(Auth::Session),
          fields: T.untyped,
        ).returns(T.nilable(Shop))
      end
      def current_shop(session: Context.active_session, fields: nil)
        Shop.all(session: T.must(session), fields: fields).first
      end

      sig { returns(T.nilable(RecurringApplicationCharge)) }
      def current_recurring_application_charge
        RecurringApplicationCharge.all.find { |c| c.status == "active" }
      end
    end
  end
end
