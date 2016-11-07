require "test_helper"

class OnlySendMutatedParamsTest < Test::Unit::TestCase
  class Fake < ShopifyAPI::Base
    include ShopifyAPI::OnlySendMutatedParams
  end

  def setup
    super
  end

  def test_creating_a_record_syncs_attributes
    fake "fakes", method: :post, status: 201, body: {
      id: 2112,
      attr: "some attr",
      attr_other: "some other attr",
    }.to_json

    fake_resource = Fake.new
    fake_resource.save

    assert_equal 2112, fake_resource.id
    assert_equal "some attr", fake_resource.attr
    assert_equal "some other attr", fake_resource.attr_other
  end

  def test_creating_a_record_only_sends_set_attributes
    fake "fakes", method: :post, status: 201, body: "{}"

    fake_resource = Fake.new
    fake_resource.attr = "new attr"
    fake_resource.save

    assert_last_request_body(fake: { attr: "new attr" })
  end

  def test_updating_a_record_only_sends_set_attributes
    fake "fakes", method: :post, status: 201, body: {
      id: 2112,
      attr: "some attr",
      attr_other: "some other attr",
    }.to_json


    fake_resource = Fake.new
    fake_resource.save

    assert_equal 2112, fake_resource.id
    assert_equal "some attr", fake_resource.attr
    assert_equal "some other attr", fake_resource.attr_other

    fake "fakes/2112", method: :put, status: 201, body: {
      id: 2112,
      attr: "new attr",
      attr_other: "some other attr",
    }.to_json

    fake_resource.attr = "new attr"
    fake_resource.save

    assert_last_request_body(fake: { attr: "new attr" })

    assert_equal 2112, fake_resource.id
    assert_equal "new attr", fake_resource.attr
    assert_equal "some other attr", fake_resource.attr_other
  end

  private

  def assert_last_request_body(expected)
    assert FakeWeb.last_request.body, expected
  end
end
