# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module VerifiableQueryTestHelper
  def test_signable_hash_key_order
    assert_equal(@subject.to_signable_hash.keys.sort, @subject.to_signable_hash.keys)
  end
end
