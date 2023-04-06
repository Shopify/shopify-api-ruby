# typed: strict
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class User202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"users" => [{"id" => 548380009, "first_name" => "John", "email" => "j.smith@example.com", "url" => "www.example.com", "im" => nil, "screen_name" => nil, "phone" => nil, "last_name" => "Smith", "account_owner" => true, "receive_announcements" => 1, "bio" => nil, "permissions" => ["applications", "beacons", "billing_application_charges", "channels", "content", "content_entries_delete", "content_entries_edit", "content_entries_view", "content_models_delete", "content_models_edit", "content_models_view", "custom_pixels_management", "custom_pixels_view", "customers", "dashboard", "domains", "draft_orders", "edit_orders", "edit_private_apps", "gift_cards", "links", "locations", "marketing", "marketing_section", "metaobjects_delete", "metaobjects_edit", "metaobjects_view", "metaobject_definitions_delete", "metaobject_definitions_edit", "metaobject_definitions_view", "orders", "overviews", "pages", "pay_draft_orders_by_credit_card", "pay_orders_by_credit_card", "pay_orders_by_vaulted_card", "preferences", "products", "refund_orders", "reports", "translations", "themes", "view_private_apps", "shopify_payments_accounts", "shopify_payments_transfers", "staff_audit_log_view", "staff_management_update", "applications_billing", "attestation_authority", "authentication_management", "balance_bank_accounts_management", "billing_charges", "billing_invoices_pay", "billing_invoices_view", "billing_payment_methods_manage", "billing_payment_methods_view", "billing_settings", "billing_subscriptions", "capital", "shopify_credit", "customer_private_data", "erase_customer_data", "request_customer_data", "domains_management", "domains_transfer_out", "enable_private_apps", "experiments_management", "gdpr_actions", "manage_tap_to_pay", "payment_settings", "upgrade_to_plus_plan", "shopify_payments", "staff_api_permission_management", "staff_management", "staff_management_activation", "staff_management_create", "staff_management_delete", "support_methods", "collaborator_request_management", "collaborator_request_settings", "export_customers", "export_draft_orders", "export_orders", "export_products"], "locale" => "en", "user_type" => "regular", "admin_graphql_api_id" => "gid://shopify/StaffMember/548380009", "tfa_enabled?" => false}, {"id" => 930143300, "first_name" => "John", "email" => "j.limited@example.com", "url" => "www.example.com", "im" => nil, "screen_name" => nil, "phone" => nil, "last_name" => "Limited", "account_owner" => false, "receive_announcements" => 1, "bio" => nil, "permissions" => [], "locale" => "en", "user_type" => "regular", "admin_graphql_api_id" => "gid://shopify/StaffMember/930143300", "tfa_enabled?" => false}]}), headers: {})

    ShopifyAPI::User.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users/548380009.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"user" => {"id" => 548380009, "first_name" => "John", "email" => "j.smith@example.com", "url" => "www.example.com", "im" => nil, "screen_name" => nil, "phone" => nil, "last_name" => "Smith", "account_owner" => true, "receive_announcements" => 1, "bio" => nil, "permissions" => ["applications", "beacons", "billing_application_charges", "channels", "content", "content_entries_delete", "content_entries_edit", "content_entries_view", "content_models_delete", "content_models_edit", "content_models_view", "custom_pixels_management", "custom_pixels_view", "customers", "dashboard", "domains", "draft_orders", "edit_orders", "edit_private_apps", "gift_cards", "links", "locations", "marketing", "marketing_section", "metaobjects_delete", "metaobjects_edit", "metaobjects_view", "metaobject_definitions_delete", "metaobject_definitions_edit", "metaobject_definitions_view", "orders", "overviews", "pages", "pay_draft_orders_by_credit_card", "pay_orders_by_credit_card", "pay_orders_by_vaulted_card", "preferences", "products", "refund_orders", "reports", "translations", "themes", "view_private_apps", "shopify_payments_accounts", "shopify_payments_transfers", "staff_audit_log_view", "staff_management_update", "applications_billing", "attestation_authority", "authentication_management", "balance_bank_accounts_management", "billing_charges", "billing_invoices_pay", "billing_invoices_view", "billing_payment_methods_manage", "billing_payment_methods_view", "billing_settings", "billing_subscriptions", "capital", "shopify_credit", "customer_private_data", "erase_customer_data", "request_customer_data", "domains_management", "domains_transfer_out", "enable_private_apps", "experiments_management", "gdpr_actions", "manage_tap_to_pay", "payment_settings", "upgrade_to_plus_plan", "shopify_payments", "staff_api_permission_management", "staff_management", "staff_management_activation", "staff_management_create", "staff_management_delete", "support_methods", "collaborator_request_management", "collaborator_request_settings", "export_customers", "export_draft_orders", "export_orders", "export_products"], "locale" => "en", "user_type" => "regular", "admin_graphql_api_id" => "gid://shopify/StaffMember/548380009", "tfa_enabled?" => false}}), headers: {})

    ShopifyAPI::User.find(
      id: 548380009,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users/548380009.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users/current.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"user" => {"id" => 548380009, "first_name" => "John", "email" => "j.smith@example.com", "url" => "www.example.com", "im" => nil, "screen_name" => nil, "phone" => nil, "last_name" => "Smith", "account_owner" => true, "receive_announcements" => 1, "bio" => nil, "permissions" => ["applications", "beacons", "billing_application_charges", "channels", "content", "content_entries_delete", "content_entries_edit", "content_entries_view", "content_models_delete", "content_models_edit", "content_models_view", "custom_pixels_management", "custom_pixels_view", "customers", "dashboard", "domains", "draft_orders", "edit_orders", "edit_private_apps", "gift_cards", "links", "locations", "marketing", "marketing_section", "metaobjects_delete", "metaobjects_edit", "metaobjects_view", "metaobject_definitions_delete", "metaobject_definitions_edit", "metaobject_definitions_view", "orders", "overviews", "pages", "pay_draft_orders_by_credit_card", "pay_orders_by_credit_card", "pay_orders_by_vaulted_card", "preferences", "products", "refund_orders", "reports", "translations", "themes", "view_private_apps", "shopify_payments_accounts", "shopify_payments_transfers", "staff_audit_log_view", "staff_management_update", "applications_billing", "attestation_authority", "authentication_management", "balance_bank_accounts_management", "billing_charges", "billing_invoices_pay", "billing_invoices_view", "billing_payment_methods_manage", "billing_payment_methods_view", "billing_settings", "billing_subscriptions", "capital", "shopify_credit", "customer_private_data", "erase_customer_data", "request_customer_data", "domains_management", "domains_transfer_out", "enable_private_apps", "experiments_management", "gdpr_actions", "manage_tap_to_pay", "payment_settings", "upgrade_to_plus_plan", "shopify_payments", "staff_api_permission_management", "staff_management", "staff_management_activation", "staff_management_create", "staff_management_delete", "support_methods", "collaborator_request_management", "collaborator_request_settings", "export_customers", "export_draft_orders", "export_orders", "export_products"], "locale" => "en", "user_type" => "regular", "admin_graphql_api_id" => "gid://shopify/StaffMember/548380009", "tfa_enabled?" => false}}), headers: {})

    ShopifyAPI::User.current

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/users/current.json")
  end

end
