class Badge < ApplicationRecord
  belongs_to :programme
  validates :credly_badge_template_id, presence: true, uniqueness: true
  validates :academic_year, presence: true

  scope :active, -> { where(active: true) }
end
