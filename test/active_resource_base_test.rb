require 'test_helper'

class ActiveResourceBaseTest < Test::Unit::TestCase

  test '#build should merge additional attributes' do
    Person = Class.new(ActiveResource::Base) do
      self.site = "http://localhost/admin"
    end
    fake "people/new", :method => :get, :status => 200, :body => '{"person":{}}'
    person = Person.build(name: "Joe")
    assert_equal "Joe", person.name
  end


  if ActiveResource::VERSION::MAJOR >= 4
    test '#build should use attributes to build resource paths' do
      StreetAddress = Class.new(ActiveResource::Base) do
        self.site = "http://localhost/admin/people/:person_id"
        self.element_name = 'address'
      end
      fake "people/1/addresses/new", :method => :get, :status => 200, :body => '{"address":{"city":"Toronto"}}'
      address = StreetAddress.build(person_id: 1)
      assert_equal 'Toronto', address.city
    end
  end

end
