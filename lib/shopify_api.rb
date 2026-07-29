# typed: strict
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require "oj"
require "sorbet-runtime"
require "securerandom"
require "cgi"
require "uri"
require "logger"
require "openssl"
require "httparty"
require "zeitwerk"
require "jwt"
require "concurrent"

require_relative "shopify_api/inflector"
require_relative "shopify_api/admin_versions"
require_relative "shopify_api/webhooks/webhook_handler"

loader = Zeitwerk::Loader.for_gem
loader.inflector = ShopifyAPI::Inflector.new(__FILE__)
loader.ignore("#{__dir__}/shopify_api/rest/resources")
loader.setup

module ShopifyAPI
  REST_RESOURCES_PATH = T.let("#{__dir__}/shopify_api/rest/resources", String)

  class << self
    extend T::Sig

    # REST resources are only autoloaded for API versions this gem bundles (see
    # Context.load_rest_resources). Without this hook, using a version whose
    # resources aren't bundled - a newly released version, or `unstable` - fails
    # with a bare "uninitialized constant", which reads like a gem bug instead
    # of a version-coverage gap. GraphQL and the REST client are unaffected.
    sig { params(name: Symbol).returns(T.untyped) }
    def const_missing(name)
      if bundled_rest_resource_names.include?(name.to_s)
        # Pass `name` through so NameError#name still returns the missing
        # constant, as it does for the NameError Ruby would have raised.
        raise Errors::RestResourceNotLoadedError.new(rest_resource_not_loaded_message(name), name)
      end

      super
    end

    private

    # Constant names of every REST resource bundled for any API version, derived
    # the same way Zeitwerk derives them so the two cannot drift.
    sig { returns(T::Array[String]) }
    def bundled_rest_resource_names
      @bundled_rest_resource_names ||= T.let(
        Dir.glob("#{REST_RESOURCES_PATH}/*/*.rb").map do |path|
          Zeitwerk::Inflector.new.camelize(File.basename(path, ".rb"), path)
        end.uniq,
        T.nilable(T::Array[String]),
      )
    end

    sig { returns(T::Array[String]) }
    def bundled_rest_resource_versions
      @bundled_rest_resource_versions ||= T.let(
        Dir.glob("#{REST_RESOURCES_PATH}/*")
          .select { |path| File.directory?(path) }
          .map { |path| File.basename(path).tr("_", "-") }
          .sort,
        T.nilable(T::Array[String]),
      )
    end

    sig { params(name: Symbol).returns(String) }
    def rest_resource_not_loaded_message(name)
      api_version = Context.api_version

      reason = if api_version.empty?
        "ShopifyAPI::Context has not been set up, so no REST resources have been loaded. " \
          "Call ShopifyAPI::Context.setup before using REST resources."
      elsif api_version == "unstable"
        "REST resources are not bundled for the \"unstable\" API version. Set api_version to a " \
          "stable version to use REST resources, or use the GraphQL Admin API."
      else
        "shopify_api #{VERSION} does not bundle REST resources for API version \"#{api_version}\" " \
          "(latest bundled: \"#{bundled_rest_resource_versions.last}\"). Upgrade the gem, set " \
          "api_version to a bundled version, or use the GraphQL Admin API."
      end

      "uninitialized constant ShopifyAPI::#{name}. #{reason}"
    end
  end
end
