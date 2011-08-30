module ShopifyAPI
  class RecurringApplicationCharge < Base
    undef_method :test
    
    class << self
      # generate a method for each type of recurring application charge
      [:current, :pending, :cancelled, :accepted, :declined].each do |m|
        define_method(m) { all.find { |c| c.status == m.to_s } }
      end
    end
    
    def cancel
      load_attributes_from_response(self.destroy)
    end
    
    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
