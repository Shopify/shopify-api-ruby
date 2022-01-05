# typed: strict
# frozen_string_literal: true

require "active_support/inflector"
require "pry"

module ShopifyAPI
  module RestWrappers
    class Base
      extend T::Sig
      extend T::Helpers
      abstract!

      @has_one = T.let({}, T::Hash[Symbol, Class])
      @has_many = T.let({}, T::Hash[Symbol, Class])

      sig { returns(T::Hash[Symbol, T.untyped]) }
      attr_reader :original_state

      sig { params(session: T.nilable(Auth::Session)).void }
      def initialize(session: nil)
        @original_state = T.let({}, T::Hash[Symbol, T.untyped])

        session = Utils::SessionUtils.load_current_session if !session && Context.private?
        raise Errors::SessionNotFoundError, "No provided session for public app." unless session

        client = ShopifyAPI::Clients::Rest::Admin.new(session)

        @session = T.let(session, Auth::Session)
        @client = T.let(client, Clients::Rest::Admin)
      end

      class << self
        extend T::Sig

        sig do
          params(
            id: T.nilable(T.any(Integer, String)),
            session: T.nilable(Auth::Session),
            ids: T::Hash[Symbol, String],
            params: T::Hash[Symbol, T.untyped],
          ).returns(T::Array[Base])
        end
        def base_find(id: nil, session: nil, ids: {}, params: {})
          session = Utils::SessionUtils.load_current_session if !session && Context.private?
          raise Errors::SessionNotFoundError, "No provided session for non-private app." unless session

          client = ShopifyAPI::Clients::Rest::Admin.new(session)

          path = get_path(operation: :get, ids: id ? { id: id } : ids)
          response = client.get(path: path, query: params.compact)

          create_instances_from_response(response: response, session: session)
        end

        sig { returns(String) }
        def class_name
          T.must(name).demodulize.underscore
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
          abstract.params(
            operation: Symbol,
            entity: T.nilable(Base),
            ids: T::Hash[Symbol, T.any(Integer, String)]
          ).returns(String)
        end
        def get_path(operation:, entity: nil, ids: {}); end

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

      sig { void }
      def delete
        @client.delete(path: self.class.get_path(operation: :delete, entity: self))
      end

      sig { void }
      def save!
        save(update_object: true)
      end

      sig { params(update_object: T::Boolean).void }
      def save(update_object: false)
        hash = generate_changed_hash
        method = hash["id"] ? :put : :post

        response = @client.public_send(method,
          body: { self.class.class_name.downcase => hash },
          path: self.class.get_path(operation: method, entity: self))

        if update_object
          self.class.create_instance(
            data: response.body[self.class.class_name.downcase],
            session: @session, instance: self
          )
        end
      end

      sig { returns(T::Hash[String, T.untyped]) }
      def generate_changed_hash
        hash = {}

        instance_variables.each do |var|
          next if [:"@original_state", :"@session", :"@client"].include?(var)

          attribute = var.to_s.delete("@").to_sym
          if self.class.has_many?(attribute)
            elements = []
            element_changed = T.let(false, T::Boolean)
            (instance_variable_get(var) || []).each do |element|
              element_hash = element.generate_changed_hash
              elements << element_hash if element_hash
              if element_hash.keys != ["id"] && !element_hash.keys.empty?
                element_changed = true
              end
            end

            hash[attribute.to_s] = elements if element_changed
          elsif self.class.has_one?(attribute)
            element_hash = instance_variable_get(var)&.generate_changed_hash || {}
            if element_hash.keys != ["id"] && !element_hash.keys.empty?
              hash[attribute.to_s] = element_hash
            end
          elsif instance_variable_get(var) != original_state[attribute] || var == "@id".to_sym
            hash[attribute.to_s] = instance_variable_get(var)
          end
        end

        hash
      end
    end
  end
end
