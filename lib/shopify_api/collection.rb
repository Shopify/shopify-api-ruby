# frozen_string_literal: true

module ShopifyAPI
  # The Shopify API paginates the resources on the server. By default it will
  # return 50 entries, and a maximum of 250. This custom collection for
  # ActiveResource provides the current page, limit, and total number of
  # entries available.
  #
  # @example
  #   # Assuming there are 1,000 products in the shop.
  #   products = ShopifyAPI::Product.all(params: { page: 2, limit: 100 })
  #   products.current_page # => 2
  #   products.count # => 100
  #   products.total_count # => 1000
  #   products.total_pages # => 10
  #   products.prev_page # => 1
  #   products.next_page # => 3
  class Collection
    include Enumerable

    delegate :to_yaml, :all?, *Array.instance_methods(false), to: :to_a

    attr_accessor :elements, :resource_class, :original_params

    # The default amount of entries Shopify responds with if no limit is set.
    DEFAULT_LIMIT = 50

    # @param [Array<ShopifyAPI::Base>] elements
    # @return [ShopifyAPI::Collection]
    def initialize(elements = [])
      @elements = elements
    end

    # @return [self]
    def collect!
      return elements unless block_given?

      set = []

      each { |entry| set << yield(entry) }

      @elements = set

      self
    end

    alias map! collect!

    # The page number that the collection is currently populated with.
    #
    # @return [Integer] The current page.
    def current_page
      @current_page ||= original_params.fetch(:page, 1).to_i
    end

    # Finds the first entry with the given attributes, or creates it if it does
    # not exist.
    #
    # @param [Hash] attributes The search attributes.
    # @return [ShopifyAPI::Base] The entry that was found or created.
    def first_or_create(attributes = {})
      first || resource_class.create(original_params.update(attributes))
    rescue NoMethodError
      resource_type = resource_class.inspect

      raise "Cannot create resource from resource type: #{resource_type}"
    end

    # Finds the first entry with the given attributes, or initializes a new
    # one if it does not exist on the server.
    #
    # @param [Hash] attributes The search attributes.
    # @return [ShopifyAPI::Base] The entry that was found or initialized.
    def first_or_initialize(attributes = {})
      first || resource_class.new(original_params.update(attributes))
    rescue NoMethodError
      resource_type = resource_class.inspect

      raise "Cannot build resource from resource type: #{resource_type}"
    end

    # Checks if the collection is on the first page.
    #
    # @return [true, false] If the current page is the first one.
    def first_page?
      current_page.equal?(1)
    end

    # Checks if the collection is on the last page.
    #
    # @return [true, false] If the current page is the last one.
    def last_page?
      current_page.equal?(total_pages)
    end

    # The maximum amount of records each page can have.
    #
    # @return [Integer] Maximum number entries per page.
    def limit
      @limit ||= original_params.fetch(:limit, DEFAULT_LIMIT).to_i
    end

    # Gets the number of the next page.
    #
    # @return [Integer, NilClass] The next page, or nil if on the last one.
    def next_page
      current_page + 1 unless last_page?
    end

    # Gets the number of the previous page.
    #
    # @return [Integer, NilClass] The previous page, or nil if on the first one.
    def prev_page
      current_page - 1 unless first_page?
    end

    # Converts the collection to an array.
    #
    # @return [Array<ShopifyAPI::Base>] All of the entries in the collection.
    def to_a
      elements
    end

    # Gets the total number of entries available for the given request. The
    # #count method will return the number of entries in the current
    # collection. This will return the total number of entries available for
    # the parameters provided to the request.
    #
    # @return [Integer] Total number of non-paginated entries.
    def total_count
      @total_count ||= begin
        # Get the parameters without the pagination parameters.
        params = original_params.with_indifferent_access.except(:page, :limit)

        # Ask Shopify how many records there are for the given query.
        resource_class.count(params)
      end
    end

    # Calculates the total number of expected pages based on the number
    # reported by the API.
    #
    # @return [Integer] Total number of pages.
    def total_pages
      @total_pages ||= (total_count.to_f / limit.to_f).ceil
    end
  end
end
