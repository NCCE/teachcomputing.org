class Activity < ApplicationRecord
  has_many :achievements, dependent: :restrict_with_exception
  has_many :users, through: :achievements
end
