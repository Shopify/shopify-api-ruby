require 'test_helper'

class ApplicationChargeTest < Test::Unit::TestCase

  def test_application_charge_create
    fake "application_charges", :method => :post, :status => 201, :body => load_fixture('application_charge')

    charge = ShopifyAPI::ApplicationCharge.create(
        name: "iPod Cleaning",
        price: 5.00,
        return_url: "http://google.com"
    )

    assert_equal 'https://this-is-my-test-shop.myshopify.com/admin/charges/803742/confirm_application_charge?signature=BAhpA55DDA%3D%3D--55b44e274e438c619be4631c804abcbcb6ee915a', charge.confirmation_url
  end

  def test_get_application_charge
    fake "application_charges/803742", :method => :get, :status => 201, :body => load_fixture('application_charge')

    charge = ShopifyAPI::ApplicationCharge.find(803742)

    assert_equal "iPod Cleaning", charge.name
  end

  def test_list_application_charges
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')

    charges = ShopifyAPI::ApplicationCharge.find(:all)

    assert_equal 4, charges.size
    assert_equal "iPhone Case", charges.last.name
  end

  def test_list_pending_application_charges
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')

    pending_charges = ShopifyAPI::ApplicationCharge.pending

    assert_equal 1, pending_charges.size
    assert_equal "Screen Replacement", pending_charges.first.name
  end

  def test_list_expired_application_charges
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')

    expired_charges = ShopifyAPI::ApplicationCharge.expired

    assert_equal 1, expired_charges.size
    assert_equal "iPod Cleaning", expired_charges.first.name
  end

  def test_list_accepted_application_charges
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')

    accepted_charges = ShopifyAPI::ApplicationCharge.accepted

    assert_equal 1, accepted_charges.size
    assert_equal "iPhone Case", accepted_charges.first.name
  end

  def test_list_declined_application_charges
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')

    declined_charges = ShopifyAPI::ApplicationCharge.declined

    assert_equal 1, declined_charges.size
    assert_equal "Magic Mouse", declined_charges.first.name
  end

  def test_activate_application_charge
    fake "application_charges", :method => :get, :status => 201, :body => load_fixture('application_charges')
    fake "application_charges/803740/activate", :method => :post, :status => 200, :body => "{}"

    charge = ShopifyAPI::ApplicationCharge.accepted

    assert charge.last.activate
  end

end
