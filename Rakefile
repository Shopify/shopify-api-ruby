# typed: false
# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  Rake::TestTask.new(:library) do |t|
    t.test_files = FileList["test/**/*_test.rb"].exclude("test/rest_wrappers/**/*.rb")
  end

  Rake::TestTask.new(:rest_wrappers) do |t|
    pattern = if ENV.key?("API_VERSION")
      "test/rest_wrappers/**/#{ENV["API_VERSION"]}/*.rb"
    else
      "test/rest_wrappers/**/*.rb"
    end

    t.pattern = pattern
  end
end

task test: ["test:library"]
