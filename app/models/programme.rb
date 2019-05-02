class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_one  :assessment, dependent: :destroy

  validates :title, :description, :slug, presence: true
end
