require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get properties_url
    assert_response :success
  end

  test "should get new" do
    get new_property_url
    assert_response :success
  end

  test "should create property" do
    assert_difference("Property.count") do
      post properties_url, params: { property: { bathrooms: @property.bathrooms, bedrooms: @property.bedrooms, description: @property.description, kitchens: @property.kitchens, owner: @property.owner, property_address: @property.property_address, property_type: @property.property_type, sitting_rooms: @property.sitting_rooms, toilets: @property.toilets, valid_from: @property.valid_from, valid_to: @property.valid_to } }
    end

    assert_redirected_to property_url(Property.last)
  end

  test "should show property" do
    get property_url(@property)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_url(@property)
    assert_response :success
  end

  test "should update property" do
    patch property_url(@property), params: { property: { bathrooms: @property.bathrooms, bedrooms: @property.bedrooms, description: @property.description, kitchens: @property.kitchens, owner: @property.owner, property_address: @property.property_address, property_type: @property.property_type, sitting_rooms: @property.sitting_rooms, toilets: @property.toilets, valid_from: @property.valid_from, valid_to: @property.valid_to } }
    assert_redirected_to property_url(@property)
  end

  test "should destroy property" do
    assert_difference("Property.count", -1) do
      delete property_url(@property)
    end

    assert_redirected_to properties_url
  end
end
