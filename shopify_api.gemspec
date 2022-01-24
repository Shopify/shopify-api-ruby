# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("../lib", __FILE__))
require "shopify_api/version"

Gem::Specification.new do |s|
  s.name = "shopify_api"
  s.version = ShopifyAPI::VERSION
  s.author = "Shopify"

  s.summary = "The gem for accessing the Shopify API"
  s.description = <<~HERE
    This gem allows Ruby developers to programmatically access the admin
    section of Shopify stores.
  HERE
  s.email = "developers@shopify.com"
  s.homepage = "https://shopify.dev/apps"

  s.metadata["allowed_push_host"] = "https://rubygems.org"

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md",
  ]
  s.files         = %x(git ls-files).split("\n")
  s.test_files    = %x(git ls-files -- {test}/*).split("\n")

  s.rdoc_options = ["--charset=UTF-8"]

  s.license = "MIT"

  s.required_ruby_version = ">= 2.6"

  s.add_runtime_dependency("concurrent-ruby")
  s.add_runtime_dependency("hash_diff")
  s.add_runtime_dependency("httparty")
  s.add_runtime_dependency("jwt")
  s.add_runtime_dependency("oj")
  s.add_runtime_dependency("openssl")
  s.add_runtime_dependency("securerandom")
  s.add_runtime_dependency("sorbet-runtime")
  s.add_runtime_dependency("zeitwerk", "~> 2.5")

  s.add_development_dependency("activesupport")
  s.add_development_dependency("rake")
  s.add_development_dependency("rubocop")
  s.add_development_dependency("rubocop-shopify")
  s.add_development_dependency("rubocop-sorbet")
  s.add_development_dependency("sorbet")
  s.add_development_dependency("tapioca")
end
