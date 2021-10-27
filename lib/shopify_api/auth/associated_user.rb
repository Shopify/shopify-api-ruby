# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class AssociatedUser < T::Struct
      prop :id, Integer
      prop :first_name, String
      prop :last_name, String
      prop :email, String
      prop :email_verified, T::Boolean
      prop :account_owner, T::Boolean
      prop :locale, String
      prop :collaborator, T::Boolean
    end
  end
end
