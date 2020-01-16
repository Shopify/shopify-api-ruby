# frozen_string_literal: true
require 'graphql'

module DummySchema
  class Product < GraphQL::Schema::Object
    field :name, String, null: false
  end

  class QueryRoot < GraphQL::Schema::Object
    field :product, Product, null: false
  end

  class Schema < GraphQL::Schema
    query(QueryRoot)
  end
end
