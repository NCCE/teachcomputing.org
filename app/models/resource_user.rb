class ResourceUser < ApplicationRecord
  validates :user_id, presence: true
  validates :resource_year, presence: true
  validates :user_id, uniqueness: {scope: [:resource_year]}
  validates :counter, presence: true

  belongs_to :user
end
