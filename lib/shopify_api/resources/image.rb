# frozen_string_literal: true
module ShopifyAPI
  class Image < Base
    init_prefix :product

    # generate a method for each possible image variant
    [:pico, :icon, :thumb, :small, :compact, :medium, :large, :grande, :original].each do |m|
      reg_exp_match = "/\\1_#{m}.\\2"
      define_method(m) { src.gsub(%r/\/(.*)\.(\w{2,4})/, reg_exp_match) }
    end

    def attach_image(data, filename = nil)
      attributes['attachment'] = Base64.encode64(data)
      attributes['filename'] = filename unless filename.nil?
    end
  end
end
