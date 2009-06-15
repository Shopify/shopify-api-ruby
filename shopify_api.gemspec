# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shopify_api}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Lütke", "Cody Fauser", "Dennis Theisen"]
  s.date = %q{2009-06-15}
  s.description = %q{= Shopify API  The Shopify API gem allows Ruby developers to programmatically access the admin section of Shopify stores.  The API is implemented as XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation. In other words, we’ve tried to make the API follow the REST principles as much as possible.   == Usage  === Requirements  All API usage happens through Shopify applications, created by either shop owners for their own shops, or by Shopify Partners for use by shop owners:  * Shop owners can create applications for themselves through their own admin (under the Preferences > Applications tab). * Shopify Partners create applications through their admin.  For more information and detailed documentation visit http://api.shopify.com  === Getting Started  ShopifyAPI uses ActiveResource to communicate with the REST web service. ActiveResource has to be configured with a fully authorized URL of a particular store first. To obtain that URL you can follow these steps:  1. First create a new application in either the partners admin or your store admin and write down your API_KEY and SHARED_SECRET.  2. You will need to supply two parameters to the Session class before you instantiate it:  ShopifyAPI::Session.setup({:api_key => API_KEY, :secret => SHARED_SECRET})  3. Create a new Session for a specific shop. That session is not fully valid yet, but it can be used to create a URL that you will redirect your users to:  session = ShopifyAPI::Session.new("yourshopname.myshopify.com") session.valid?  # returns false  4. To access the API shop owners need a "token" from that specific shop. In order to get this token they need to authorize with that shop first. The URL to redirect your user to can be generated via:  url = session.create_permission_url  5. After visiting this URL, the shop redirects the owner to a custom URL of your application where the "token" gets sent to (it's param name is just "t"). Use that token to instantiate a "valid" session, that is ready to make calls to that particular shop.  token = params[:t] session = ShopifyAPI::Session.new("yourshopname.myshopify.com", token) session.valid?  # returns true  6. Now you can finally get the fully authorized URL for that shop. Use that URL to configure ActiveResource and you're set:  ActiveResource::Base.site = session.site  7. Get data from that shop (returns ActiveResource instances):  shop = ShopifyAPI::Shop.current latest_orders = ShopifyAPI::Order.find(:all)  == Copyright  Copyright (c) 2009 "JadedPixel inc.". See LICENSE for details.}
  s.email = %q{developers@jadedpixel.com}
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
     "VERSION",
     "lib/shopify_api.rb",
     "shopify_api.gemspec",
     "test/shopify_api_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Shopify/shopify_api}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{shopify-api}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{ShopifyAPI is a lightweight gem for accessing the Shopify admin REST web services}
  s.test_files = [
    "test/shopify_api_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activeresource>, [">= 2.2.2"])
    else
      s.add_dependency(%q<activeresource>, [">= 2.2.2"])
    end
  else
    s.add_dependency(%q<activeresource>, [">= 2.2.2"])
  end
end
