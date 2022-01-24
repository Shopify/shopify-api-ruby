# frozen_string_literal: true

source "https://rubygems.org"

gem "securerandom"
gem "oj"
gem "httparty"
gem "jwt"

gem "sorbet-runtime"
gem "openssl"
gem "zeitwerk", "~> 2.5"
gem "hash_diff"
gem "concurrent-ruby"

group :development do
  gem "sorbet"
  gem "tapioca"

  gem "rake"

  gem "rubocop", require: false
  gem "rubocop-shopify", require: false
  gem "rubocop-sorbet", require: false
  gem "activesupport"
end

group :test do
  gem "minitest"
  gem "fakefs", require: false
  gem "webmock"
  gem "mocha"
end
