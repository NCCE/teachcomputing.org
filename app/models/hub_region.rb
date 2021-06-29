class HubRegion < ApplicationRecord
  has_many :hubs, -> { order(:name) }
  validates :name, :order, presence: true
  validates :order, uniqueness: true
end
