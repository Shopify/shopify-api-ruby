module DisablePrefixCheck
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def check_prefix_options(options)
    end
  end
end
