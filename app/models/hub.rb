class Hub < ApplicationRecord
  belongs_to :hub_region
  validates :name, :subdeliverer_id, presence: true
  geocoded_by :geocodable_address
  after_validation :geocode

  def geocodable_address
    [address, postcode].join(', ')
  end

end
