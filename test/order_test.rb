require 'test_helper'

class OrderTest < Test::Unit::TestCase
  def setup
    ActiveResource::Base.site = "http://localhost"
  end

  context "Order" do
    context "#note_attributes" do

      should "be loaded correctly from order xml" do
        order_xml = <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <order>
            <note-attributes type="array">
              <note-attribute>
                <name>size</name>
                <value>large</value>
              </note-attribute>
            </note-attributes>
          </order>
        XML

        order = ShopifyAPI::Order.new(Hash.from_xml(order_xml)["order"])

        assert_equal 1, order.note_attributes.size

        note_attribute = order.note_attributes.first
        assert_equal "size", note_attribute.name
        assert_equal "large", note_attribute.value
      end
      
      should "be able to add note attributes to an order" do
        order = ShopifyAPI::Order.new
        order.note_attributes = []
        order.note_attributes << ShopifyAPI::NoteAttribute.new(:name => "color", :value => "blue")
        
        order_xml = Hash.from_xml(order.to_xml)
        assert note_attributes = order_xml["order"]["note_attributes"]
        assert_instance_of Array, note_attributes
        
        attribute = note_attributes.first
        assert_equal "color", attribute["name"]
        assert_equal "blue", attribute["value"]
      end
    end
  end
end