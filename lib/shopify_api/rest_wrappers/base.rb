# typed: strict
# frozen_string_literal: true

require "active_support/inflector"
require "hash_diff"

module ShopifyAPI
  module RestWrappers
    class Base
      extend T::Sig
      extend T::Helpers
      abstract!

      @has_one = T.let({}, T::Hash[Symbol, Class])
      @has_many = T.let({}, T::Hash[Symbol, Class])
      @paths = T.let([], T::Array[T::Hash[Symbol, T.any(T::Array[Symbol], String, Symbol)]])

      sig { returns(T::Hash[Symbol, T.untyped]) }
      attr_accessor :original_state

      sig do
        params(
          session: T.nilable(Auth::Session),
          from_hash: T.nilable(T::Hash[Symbol, T.untyped]),
        ).void
      end
      def initialize(session: nil, from_hash: nil)
        @original_state = T.let({}, T::Hash[Symbol, T.untyped])
        @forced_nils = T.let({}, T::Hash[String, T::Boolean])

        session = Utils::SessionUtils.load_current_session if !session && Context.private?
        raise Errors::SessionNotFoundError, "No provided session for public app." unless session

        client = ShopifyAPI::Clients::Rest::Admin.new(session)

        @session = T.let(session, Auth::Session)
        @client = T.let(client, Clients::Rest::Admin)

        from_hash&.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      class << self
        extend T::Sig

        sig do
          params(
            session: T.nilable(Auth::Session),
            ids: T::Hash[Symbol, String],
            params: T::Hash[Symbol, T.untyped],
          ).returns(T::Array[Base])
        end
        def base_find(session: nil, ids: {}, params: {})
          session = Utils::SessionUtils.load_current_session if !session && Context.private?
          raise Errors::SessionNotFoundError, "No provided session for non-private app." unless session

          client = ShopifyAPI::Clients::Rest::Admin.new(session)

          path = T.must(get_path(http_method: :get, operation: :get, ids: ids))
          response = client.get(path: path, query: params.to_h { |k, v| [k, v.is_a?(Array) ? v.join(",") : v] }.compact)

          create_instances_from_response(response: response, session: session)
        end

        sig { returns(String) }
        def class_name
          T.must(name).demodulize.underscore
        end

        sig { returns(String) }
        def primary_key
          "id"
        end

        sig { returns(String) }
        def json_body_name
          class_name.underscore
        end

        sig { params(attribute: Symbol).returns(T::Boolean) }
        def has_many?(attribute)
          @has_many.include?(attribute)
        end

        sig { params(attribute: Symbol).returns(T::Boolean) }
        def has_one?(attribute)
          @has_one.include?(attribute)
        end

        sig do
          params(
            http_method: Symbol,
            operation: Symbol,
            entity: T.nilable(Base),
            ids: T::Hash[Symbol, T.any(Integer, String)]
          ).returns(T.nilable(String))
        end
        def get_path(http_method:, operation:, entity: nil, ids: {})
          match = T.let(nil, T.nilable(String))
          max_ids = T.let(-1, Integer)
          @paths.each do |path|
            next if http_method != path[:http_method] || operation != path[:operation]
            path_ids = T.cast(path[:ids], T::Array[Symbol])

            url_ids = ids.transform_keys(&:to_sym)
            path_ids.each do |id|
              if url_ids[id].nil? && (entity_id = entity&.public_send(id))
                url_ids[id] = entity_id
              end
            end

            url_ids.compact!

            # We haven't found all the required ids or we have a more specific match
            next if !(path_ids - url_ids.keys).empty? || path_ids.length <= max_ids

            max_ids = path_ids.length
            match = T.cast(path[:path], String).gsub(/(<([^>]+)>)/) do
              url_ids[T.unsafe(Regexp.last_match)[2].to_sym]
            end
          end

          match
        end

        sig do
          params(
            http_method: Symbol,
            operation: T.any(String, Symbol),
            session: T.nilable(Auth::Session),
            path_ids: T::Hash[Symbol, String],
            params: T::Hash[Symbol, T.untyped],
            body: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            entity: T.untyped,
          ).returns(T.untyped)
        end
        def request(http_method:, operation:, session:, path_ids: {}, params: {}, body: nil, entity: nil)
          session = Utils::SessionUtils.load_current_session if !session && Context.private?
          raise Errors::SessionNotFoundError, "No provided session for non-private app." unless session

          client = ShopifyAPI::Clients::Rest::Admin.new(session)

          path = get_path(http_method: http_method, operation: operation.to_sym, ids: path_ids)

          case http_method
          when :get
            client.get(path: T.must(path), query: params.compact)
          when :post
            client.post(path: T.must(path), query: params.compact, body: body || {})
          when :put
            client.put(path: T.must(path), query: params.compact, body: body || {})
          when :delete
            client.delete(path: T.must(path), query: params.compact)
          end
        end

        sig { params(response: Clients::HttpResponse, session: Auth::Session).returns(T::Array[Base]) }
        def create_instances_from_response(response:, session:)
          objects = []

          body = T.cast(response.body, T::Hash[String, T.untyped])

          if body.key?(class_name)
            objects << create_instance(data: body[class_name], session: session)
          elsif body.key?(class_name.pluralize)
            body[class_name.pluralize].each do |entry|
              objects << create_instance(data: entry, session: session)
            end
          end

          objects
        end

        sig do
          params(data: T::Hash[String, T.untyped], session: Auth::Session, instance: T.nilable(Base)).returns(Base)
        end
        def create_instance(data:, session:, instance: nil)
          instance ||= new(session: session)
          instance.original_state = {}

          unless data.empty?
            # This retrieves all the setters on the resource and calls them with the data
            instance_methods(false).select { |method| !method.to_s.include?("=") }.each do |attribute|
              next unless data.key?(attribute.to_s)

              if has_many?(attribute)
                attr_list = []
                data[attribute.to_s].each do |element|
                  attr_list << T.unsafe(@has_many[attribute]).create_instance(data: element, session: session)
                end
                instance.public_send("#{attribute}=", attr_list)
              elsif has_one?(attribute)
                instance.public_send("#{attribute}=",
                  T.unsafe(@has_one[attribute]).create_instance(data: data[attribute.to_s], session: session))
              else
                instance.public_send("#{attribute}=", data[attribute.to_s])
                instance.original_state[attribute] = data[attribute.to_s]
              end
            end
          end

          instance
        end
      end

      sig { params(meth_id: Symbol, val: T.untyped).void }
      def method_missing(meth_id, val = nil)
        match = meth_id.id2name.match(/([^=]+)=/)

        return super unless match

        var = match[1]

        instance_variable_set("@#{var}", val)
        @forced_nils[T.must(var)] = val.nil?
      end

      sig { params(meth_id: Symbol, args: T.untyped).void }
      def respond_to_missing?(meth_id, *args)
        str = meth_id.id2name
        match = str.match(/([^=]+)=/)

        match.nil? ? true : super
      end

      sig { returns(T::Hash[String, T.untyped]) }
      def to_hash
        hash = {}
        instance_variables.each do |var|
          next if [:"@original_state", :"@session", :"@client", :"@forced_nils"].include?(var)

          attribute = var.to_s.delete("@").to_sym
          if self.class.has_many?(attribute)
            hash[attribute.to_s] = instance_variable_get(var).map(&:to_hash).to_a if instance_variable_get(var)
          elsif self.class.has_one?(attribute)
            element_hash = instance_variable_get(var)&.to_hash
            hash[attribute.to_s] = element_hash if element_hash || @forced_nils[attribute.to_s]
          elsif !instance_variable_get(var).nil? || @forced_nils[attribute.to_s]
            hash[attribute.to_s] =
              instance_variable_get(var)
          end
        end
        hash
      end

      sig { params(params: T::Hash[T.untyped, T.untyped]).void }
      def delete(params: {})
        @client.delete(
          path: T.must(self.class.get_path(http_method: :delete, operation: :delete, entity: self)),
          query: params.compact
        )
      end

      sig { void }
      def save!
        save(update_object: true)
      end

      sig { params(update_object: T::Boolean).void }
      def save(update_object: false)
        hash = HashDiff::Comparison.new(original_state, to_hash).left_diff
        method = hash[self.class.primary_key] ? :put : :post

        path = self.class.get_path(http_method: method, operation: method, entity: self)
        if path.nil?
          method = method == :post ? :put : :post
          path = self.class.get_path(http_method: method, operation: method, entity: self)
        end

        response = @client.public_send(method, body: { self.class.json_body_name => hash }, path: path)

        if update_object
          self.class.create_instance(
            data: response.body[self.class.class_name.downcase],
            session: @session, instance: self
          )
        end
      end
    end
  end
end
