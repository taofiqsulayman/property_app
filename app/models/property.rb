class Property < ApplicationRecord
  validates :property_address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to, presence: true
  validates :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, numericality: { only_integer: true }
  validates :description, length: { maximum: 500 }
  validate :valid_date?

  validate :address_must_be_valid

  private

  def valid_date?
    if valid_to.present? && valid_from.present? && valid_to < valid_from
      errors.add(:valid_to, "can't be earlier than valid from date")
    end
  end

  def address_must_be_valid
    results = Geocoder.search(property_address)
    if results.empty? || !results.first.types.include?('street_address')
      errors.add(:property_address, "This address doesn't exist")
    end
  end

end
