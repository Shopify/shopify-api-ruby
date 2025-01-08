# typed: true
# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "active_support/inflector"
require "cgi"
require "concurrent"
require "fakefs/safe"
require "hash_diff"
require "httparty"
require "jwt"
require "minitest/autorun"
require "mocha"
require "mocha/minitest"
require "securerandom"
require "sorbet-runtime"
require "uri"
require "webmock/minitest"
require "zeitwerk"
