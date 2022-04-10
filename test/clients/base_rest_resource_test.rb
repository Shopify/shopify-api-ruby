# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Rest
    class BaseTest < Test::Unit::TestCase
      def setup
        @session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
          access_token: SecureRandom.alphanumeric(10))
        @prefix = "https://#{@session.shop}/admin/api/#{ShopifyAPI::Context.api_version}"
      end

      def test_finds_resource_by_id
        body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stub_request(:get, "#{@prefix}/fake_resources/1.json").to_return(body: body)

        got = TestHelpers::FakeResource.find(id: 1, session: @session)

        assert_equal([1, "attribute"], [got.id, got.attribute])
      end

      def test_finds_with_param
        body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stubbed_request = stub_request(:get, "#{@prefix}/fake_resources/1.json")
          .with(query: { param: "param" })
          .to_return(body: body)

        TestHelpers::FakeResource.find(id: 1, session: @session, param: "param")
        assert_requested(stubbed_request)
      end

      def test_finds_resource_and_children_by_id
        body = { fake_resource: {
          id: 1,
          attribute: "attribute1",
          has_one_attribute: { id: 2, attribute: "attribute2" },
          has_many_attribute: [id: 3, attribute: "attribute3"],
        } }.to_json

        stub_request(:get, "#{@prefix}/fake_resources/1.json")
          .to_return(body: body)

        got = TestHelpers::FakeResource.find(id: 1, session: @session)

        assert_equal([1, "attribute1"], [got.id, got.attribute])
        assert_equal([2, "attribute2"], [got.has_one_attribute.id, got.has_one_attribute.attribute])
        assert_equal([3, "attribute3"], [got.has_many_attribute[0].id, got.has_many_attribute[0].attribute])
      end

      def test_fails_on_finding_nonexistent_resource_by_id
        body = { errors: "Not Found" }.to_json

        stub_request(:get, "#{@prefix}/fake_resources/1.json").to_return(status: 404, body: body)

        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          TestHelpers::FakeResource.find(id: 1, session: @session)
        end
      end

      def test_finds_all_resources
        body = {
          fake_resources: [{ id: 1, attribute: "attribute1" }, { id: 2, attribute: "attribute2" }],
        }.to_json

        stub_request(:get, "#{@prefix}/fake_resources.json").to_return(body: body)

        got = TestHelpers::FakeResource.all(session: @session)

        assert_equal([1, "attribute1"], [got[0].id, got[0].attribute])
        assert_equal([2, "attribute2"], [got[1].id, got[1].attribute])
      end

      def test_saves
        request_body = { fake_resource: { attribute: "attribute" } }.to_json
        response_body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stubbed_request = stub_request(:post, "#{@prefix}/fake_resources.json")
          .with(body: request_body)
          .to_return(status: 201, body: response_body)

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.attribute = "attribute"

        resource.save
        assert_requested(stubbed_request)
        assert_nil(resource.id)
      end

      def test_saves_and_updates
        request_body = { fake_resource: { attribute: "attribute" } }.to_json
        response_body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stub_request(:post, "#{@prefix}/fake_resources.json")
          .with(body: request_body)
          .to_return(status: 201, body: response_body)

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.attribute = "attribute"

        resource.save!
        assert_equal(1, resource.id)
      end

      def test_saves_existing_resource
        request_body = { fake_resource: { id: 1, attribute: "attribute" } }
        response_body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stubbed_request = stub_request(:put, "#{@prefix}/fake_resources/1.json")
          .with(body: request_body)
          .to_return(status: 200, body: response_body)

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1
        resource.attribute = "attribute"

        resource.save
        assert_requested(stubbed_request)
      end

      def test_saves_with_children
        body = { fake_resource: {
          id: 1,
          has_one_attribute: { attribute: "attribute1" },
          has_many_attribute: [{ attribute: "attribute2" }],
        } }.to_json

        stubbed_request = stub_request(:put, "#{@prefix}/fake_resources/1.json")
          .with(body: body)
          .to_return(status: 200, body: body)

        child1 = TestHelpers::FakeResource.new(session: @session)
        child2 = TestHelpers::FakeResource.new(session: @session)
        child1.attribute = "attribute1"
        child2.attribute = "attribute2"

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1
        resource.has_one_attribute = child1
        resource.has_many_attribute = [child2]

        resource.save
        assert_requested(stubbed_request)
      end

      def test_save_ignores_unsaveable_attributes
        request_body = { fake_resource: { attribute: "attribute" } }.to_json
        response_body = { fake_resource: { id: 1, attribute: "attribute" } }.to_json

        stubbed_request = stub_request(:post, "#{@prefix}/fake_resources.json")
          .with(body: request_body)
          .to_return(status: 201, body: response_body)

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.attribute = "attribute"
        resource.unsaveable_attribute = "this is an attribute"

        resource.save
        assert_requested(stubbed_request)
        assert_nil(resource.id)
      end

      def test_deletes_existing_resource_and_fails_on_deleting_nonexistent_resource
        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1

        stubbed_request = stub_request(:delete, "#{@prefix}/fake_resources/1.json").to_return(status: 200)

        resource.delete
        assert_requested(stubbed_request)
      end

      def test_loads_unknown_attribute
        body = { fake_resource: { id: 1, attribute: "attribute", unknown: "some-value" } }.to_json

        stub_request(:get, "#{@prefix}/fake_resources/1.json").to_return(body: body)

        resource = TestHelpers::FakeResource.find(id: 1, session: @session)

        assert_equal("some-value", resource.unknown)
        assert_equal("some-value", resource.to_hash["unknown"])
      end

      def test_loads_unknown_attribute_with_special_character
        body = { fake_resource: { id: 1, attribute: "attribute", "unknown?": "some-value" } }.to_json

        stub_request(:get, "#{@prefix}/fake_resources/1.json").to_return(body: body)

        resource = TestHelpers::FakeResource.find(id: 1, session: @session)

        assert_equal("some-value", resource.unknown?)
        assert_equal("some-value", resource.to_hash["unknown?"])
      end

      def test_save_with_unknown_attribute
        request_body = { fake_resource: { unknown: "some-value" } }.to_json

        stubbed_request = stub_request(:post, "#{@prefix}/fake_resources.json")
          .with(body: request_body)
          .to_return(status: 201, body: "{}")

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.unknown = "some-value"

        resource.save
        assert_requested(stubbed_request)
      end

      def test_save_forcing_a_nil_attribute
        request_body = { fake_resource: { id: 1, has_one_attribute: nil } }.to_json

        stubbed_request = stub_request(:put, "#{@prefix}/fake_resources/1.json")
          .with(body: request_body)
          .to_return(status: 201, body: "{}")

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1
        resource.has_one_attribute = nil

        resource.save
        assert_requested(stubbed_request)
      end

      def test_create_resource_without_session
        modify_context(is_private: false)

        assert_raises(ShopifyAPI::Errors::NoActiveSessionError) { TestHelpers::FakeResource.new }
      end

      def test_makes_custom_request
        stubbed_request = stub_request(:get, "#{@prefix}/other_resources/2/fake_resources/1/custom.json")
          .to_return(status: 200, body: "test body".to_json)

        response = TestHelpers::FakeResource.custom(session: @session, id: 1, other_resource_id: 2)
        assert_requested(stubbed_request)
        assert(response, "test body")
      end

      def test_delete_resource
        stubbed_request = stub_request(:delete, "#{@prefix}/fake_resources/1.json")
          .to_return(status: 200, body: "{}")

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1
        resource.delete

        assert_requested(stubbed_request)
      end

      def test_delete_other_resource
        stubbed_request = stub_request(:delete, "#{@prefix}/other_resources/2/fake_resources/1.json")
          .to_return(status: 200, body: "{}")

        resource = TestHelpers::FakeResource.new(session: @session)
        resource.id = 1
        resource.other_resource_id = 2
        resource.delete

        assert_requested(stubbed_request)
      end

      def test_pagination
        body = { fake_resources: [] }.to_json

        stub_request(:get, "#{@prefix}/fake_resources.json")
          .to_return(body: body, headers: {
            "link" => "<#{@prefix}/fake_resources.json?page_info=page-info>; rel=\"next\"",
          })

        next_stub = stub_request(:get, "#{@prefix}/fake_resources.json?page_info=page-info")
          .to_return(body: body, headers: {
            "link" => "<#{@prefix}/fake_resources.json?page_info=page-info2>; rel=\"previous\"",
          })

        prev_stub = stub_request(:get, "#{@prefix}/fake_resources.json?page_info=page-info2").to_return(body: body)

        TestHelpers::FakeResource.all(session: @session)
        assert(TestHelpers::FakeResource.next_page?)
        refute(TestHelpers::FakeResource.prev_page?)

        TestHelpers::FakeResource.all(session: @session, page_info: TestHelpers::FakeResource.next_page_info)
        assert_requested(next_stub)
        assert(TestHelpers::FakeResource.prev_page?)
        refute(TestHelpers::FakeResource.next_page?)

        TestHelpers::FakeResource.all(session: @session, page_info: TestHelpers::FakeResource.prev_page_info)
        assert_requested(prev_stub)
        refute(TestHelpers::FakeResource.prev_page?)
        refute(TestHelpers::FakeResource.next_page?)
      end

      def test_pagination_is_thread_safe
        response_body = { fake_resources: [] }.to_json
        request_made = false

        stub_request(:get, "#{@prefix}/fake_resources.json")
          .to_return(body: response_body, headers: {
            "link" => "<#{@prefix}/fake_resources.json?page_info=page-info>; rel=\"next\"",
          })

        threads = []

        threads << Thread.new do
          sleep(0.1) until request_made

          refute(TestHelpers::FakeResource.next_page?)
        end

        threads << Thread.new do
          TestHelpers::FakeResource.all(session: @session)
          request_made = true

          assert(TestHelpers::FakeResource.next_page?)
        end

        threads.each(&:join)
      end

      def test_allows_custom_prefixes
        body = { fake_resource_with_custom_prefix: { id: 1, attribute: "attribute" } }.to_json

        prefix = "https://#{@session.shop}/admin/custom_prefix"
        stub_request(:get, "#{prefix}/fake_resource_with_custom_prefix/1.json").to_return(body: body)

        got = TestHelpers::FakeResourceWithCustomPrefix.find(id: 1, session: @session)

        assert_equal([1, "attribute"], [got.id, got.attribute])
      end
    end
  end
end
