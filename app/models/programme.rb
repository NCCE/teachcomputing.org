class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :nullify
  has_many :activities, through: :programme_activities

  validates :title, :description, :slug, presence: true
end
