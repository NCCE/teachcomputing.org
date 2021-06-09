class Hub < ApplicationRecord
  belongs_to :hub_region
  validates :name, :subdeliverer_id, presence: true
  geocoded_by :geocodable_address
  after_validation :geocode, if: :needs_geocoding?

  def geocodable_address
    [address, postcode].join(', ')
  end

  def needs_geocoding?
    return false unless address.present? && postcode.present?
    return false unless address_changed? || postcode_changed?

    true
  end
end
