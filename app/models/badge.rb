class Badge < ApplicationRecord
  belongs_to :programme
  validates :credly_badge_template_id, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
end
