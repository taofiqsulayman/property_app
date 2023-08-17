class Property < ApplicationRecord
  validates :property_address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to, presence: true
  validates :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, numericality: { only_integer: true }
  validates :description, length: { maximum: 500 }
  validate :valid_date?

  validate :validate_address

  private

  def valid_date?
    if valid_to.present? && valid_from.present? && valid_to < valid_from
      errors.add(:valid_to, "can't be earlier than valid from date")
    end
  end

  def validate_address
    require 'opencage/geocoder'

    return unless address_changed?

    geocoder = OpenCage::Geocoder.new(api_key: '43793764fe8e4cd1997acf1f1b9ce528')
    results = geocoder.geocode(property_address)

    p results.first.address

    if results.empty?
      errors.add(:property_address, 'This address is not invalid')
    else
      self.latitude = results.first.latitude
      self.longitude = results.first.longitude
    end
  end

end
