class Property < ApplicationRecord
  self.table_name = 'properties' # Specify the table name if it's different from the default 'properties' table

  validates :property_address, presence: true
  validates :property_type, presence: true
  validates :bedrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sitting_rooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :kitchens, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bathrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :toilets, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :owner, presence: true
  validates :valid_from, presence: true
  validates :valid_to, presence: true

  # Custom validation example
  validate :valid_to_after_valid_from

  private

  def valid_to_after_valid_from
    if valid_from.present? && valid_to.present? && valid_to <= valid_from
      errors.add(:valid_to, "must be after valid from date")
    end
  end
end
