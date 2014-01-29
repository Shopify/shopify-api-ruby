require 'test_helper'

class GiftCardTest < Test::Unit::TestCase
  def setup
    super
    load_gift_card
  end

  def test_disable
    fake 'gift_cards/439/disable.json', :body => load_fixture('gift_card_disabled'), :method => :post, :extension => false

    refute @gift_card.disabled_at
    @gift_card.disable
    assert @gift_card.disabled_at
  end

  def test_send_code_email
    fake 'gift_cards/439/send_code_email.json', :body => '{"email": "bob@example.com"}', :method => :post, :extension => false
    @gift_card.send_code_email
  end

  private
  def load_gift_card
    fake 'gift_cards/439', :body => load_fixture('gift_card')
    @gift_card = ShopifyAPI::GiftCard.find(439)
  end
end
