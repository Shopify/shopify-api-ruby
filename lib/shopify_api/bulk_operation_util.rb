# frozen_string_literal: true
require 'open-uri'

module ShopifyAPI
  # Helpful methods when dealing with bulk operations.
  class BulkOperationUtil
    class << self
      # A memory effective way to read nodes from a bulk operation URL. Since
      # bulk operations output nested connections as new lines in the file, we
      # must loop through each line and connect these resources. This will read
      # the file in reverse so that any child nodes will be listed first.
      def with_nested_connections(url)
        # Keep a list of nodes that will collect child nodes
        parent_nodes = {}

        # Open the file using OpenURI, this will save a temp file and will be
        # read one line at a time for memory efficiency.
        open(url) do |file|
          file.reverse_each do |line|
            next if line.blank?

            node = JSON.parse(line)

            if (parent_id = node["__parentId"])
              (parent_nodes[parent_id] ||= []) << node.except("__parentId")
            else
              node["__children"] = parent_nodes.delete(node["id"]) || []

              yield(node)
            end
          rescue JSON::ParserError => e
            raise JSON::ParserError, "Failed to parse bulk operation line " \
                                     "'#{line.truncate(150)}': #{e.message}"
          end
        end
      end
    end
  end
end