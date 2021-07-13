class HubRegion < ApplicationRecord
  has_many :hubs

  validates :name, :order, presence: true
  validates :order, uniqueness: true
end
