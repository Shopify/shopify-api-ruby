module ShopifyAPI
  class Checkout < Base
    def id
      @attributes[:token]
    end

    def pay(session_params, &block)
      vault_session = VaultSession.create(session_params)
      pay_with(vault_session, &block)
    end

    def pay_with(vault_session, &block)
      Payment.create_from(self, vault_session).tap(&block)
    end

    class Payment < Base
      self.prefix = "/admin/checkouts/:checkout_id/"

      def self.create_from(checkout, vault_session)
        create(
          checkout_id: checkout.id,
          payment: { session_id: vault_session.id },
        )
      end
    end

    class ShippingRate < Base
      self.prefix = "/admin/checkouts/:checkout_id"
    end
  end
end
