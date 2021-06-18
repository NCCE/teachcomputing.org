class Badge < ApplicationRecord
  belongs_to :programme
  validates :active, :credly_badge_template_id, presence: true
  validates :credly_badge_template_id, uniqueness: true
  validates_uniqueness_of :active, scope: :programme_id

  scope :active, -> { where(active: true) }
end
