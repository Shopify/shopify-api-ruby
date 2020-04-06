$:.push File.expand_path("../lib", __FILE__)
require "shopify_api/version"

Gem::Specification.new do |s|
  s.name = %q{shopify_api}
  s.version = ShopifyAPI::VERSION
  s.author = "Shopify"

  s.summary = %q{The Shopify API gem is a lightweight gem for accessing the Shopify admin REST web services}
  s.description = %q{The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores. The API is implemented as JSON or XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation.}
  s.email = %q{developers@jadedpixel.com}
  s.homepage = %q{http://www.shopify.com/partners/apps}

  s.metadata['allowed_push_host'] = 'https://rubygems.org'

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{ShopifyAPI is a lightweight gem for accessing the Shopify admin REST web services}
  s.license = "MIT"

  s.required_ruby_version = ">= 2.4"

  s.add_runtime_dependency("activeresource", ">= 4.1.0", "< 6.0.0")
  s.add_runtime_dependency("rack")
  s.add_runtime_dependency("graphql-client")

  s.add_development_dependency("mocha", ">= 1.4.0")
  s.add_development_dependency("webmock")
  s.add_development_dependency("minitest", ">= 4.0")
  s.add_development_dependency("rake")
  s.add_development_dependency("timecop")
  s.add_development_dependency("rubocop")
  s.add_development_dependency("pry")
  s.add_development_dependency("pry-byebug")
end
