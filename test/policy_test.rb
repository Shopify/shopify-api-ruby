require 'test_helper'

class PolicyTest < Test::Unit::TestCase
  def setup
    super
    fake 'shop'
  end

  def test_getting_the_list_of_policies
    fake 'policies'

    policies = ShopifyAPI::Policy.all
    assert_equal 1, policies.length

    policy = policies.first
    assert_equal 'Privacy Policy', policy.title
    assert_equal 'Your privacy is important to us', policy.body
  end
end
