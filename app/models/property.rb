class Property < ApplicationRecord
  validates :property_address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to, presence: true
  validates :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, numericality: { only_integer: true }
  validates :description, length: { maximum: 500 }
  validate :valid_date?

  geocoded_by :property_address

  after_validation :geocode,
    if: ->(obj){ obj.property_address.present? and obj.property_address_changed? }

  validate :property_address_must_exist

  private

  def valid_date?
    if valid_to.present? && valid_from.present? && valid_to < valid_from
      errors.add(:valid_to, "can't be earlier than valid from date")
    end
  end

  def property_address_must_exist
    if self.latitude.nil? || self.longitude.nil?
      errors.add(:property_address, "This address doesn't exist.")
    end
  end

end
