# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shopify_api}
  s.version = "1.2.5"
  s.author = "Shopify"

  s.summary = %q{The Shopify API gem is a lightweight gem for accessing the Shopify admin REST web services}
  s.description = %q{The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores. The API is implemented as XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation.}
  s.email = %q{developers@jadedpixel.com}
  s.homepage = %q{http://www.shopify.com/partners/apps}

  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CHANGELOG",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "lib/shopify_api.rb",
     "lib/shopify_api/cli.rb",
     "shopify_api.gemspec",
     "test/order_test.rb",
     "test/shopify_api_test.rb",
     "test/test_helper.rb"
  ]

  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{ShopifyAPI is a lightweight gem for accessing the Shopify admin REST web services}
  s.test_files = [
    "test/order_test.rb",
     "test/shopify_api_test.rb",
     "test/test_helper.rb"
  ]
  s.executables = ['shopify']
  s.license = 'MIT'

  s.add_dependency("activeresource", [">= 2.2.2"])
  s.add_dependency("thor", [">= 0.14.4"])
  
  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency("mocha", ">= 0.9.8")
  else
    s.add_dependency("mocha", ">= 0.9.8")
  end
end

