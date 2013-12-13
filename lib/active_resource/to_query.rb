# ActiveSupport 3.0 doesn't URL-encode paths with arrays as params properly.
# Backported from ActiveSupport > 3.0
if ActiveSupport::VERSION::MAJOR == 3 && ActiveSupport::VERSION::MINOR == 0
  class Object
    def to_query(key)
      require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
      "#{CGI.escape(key.to_param)}=#{CGI.escape(to_param.to_s)}"
    end
  end
end
