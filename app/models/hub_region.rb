class HubRegion < ApplicationRecord
  validates :name, :order, presence: true
  has_many :hubs
end
