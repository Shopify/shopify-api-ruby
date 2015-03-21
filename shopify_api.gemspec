# -*- encoding: utf-8 -*-
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

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{ShopifyAPI is a lightweight gem for accessing the Shopify admin REST web services}
  s.license = 'MIT'

  s.add_dependency("activeresource")

  dev_dependencies = [['mocha', '>= 0.9.8'],
                      ['fakeweb'], 
                      ['minitest', '~> 4.0'],
                      ['rake'],
                      ['thor', '~> 0.18.1'],
                      ['pry', ">= 0.9.12.6"]
  ]

  if s.respond_to?(:add_development_dependency)
    dev_dependencies.each { |dep| s.add_development_dependency(*dep) }
  else
    dev_dependencies.each { |dep| s.add_dependency(*dep) }
  end
end
