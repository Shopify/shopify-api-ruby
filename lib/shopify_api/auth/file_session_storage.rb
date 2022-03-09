# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class FileSessionStorage
      extend T::Sig
      extend T::Helpers
      include ShopifyAPI::Auth::SessionStorage

      sig { returns(String) }
      attr_accessor :path

      sig { params(path: String).void }
      def initialize(path: "/tmp/shopify_api_sessions")
        @path = path
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
      end

      sig do
        override.params(session: Session)
          .returns(T::Boolean)
      end
      def store_session(session)
        File.write(session_file_path(session.id), session.serialize) > 0
      end

      sig do
        override.params(id: String)
          .returns(T.nilable(Session))
      end
      def load_session(id)
        session_path = session_file_path(id)
        if File.exist?(session_path)
          ShopifyAPI::Auth::Session.deserialize(File.read(session_path))
        end
      end

      sig do
        override.params(id: String)
          .returns(T::Boolean)
      end
      def delete_session(id)
        session_path = session_file_path(id)
        File.delete(session_path) if File.exist?(session_path)
        true
      end

      alias_method :eql?, :==
      sig { params(other: T.nilable(FileSessionStorage)).returns(T::Boolean) }
      def ==(other)
        if other
          @path == other.path
        else
          false
        end
      end

      private

      sig do
        params(id: String)
          .returns(String)
      end
      def session_file_path(id)
        "#{@path}/#{id}"
      end
    end
  end
end
