class Badge < ApplicationRecord
  belongs_to :programme
  validates :credly_badge_template_id, presence: true, uniqueness: true
  validates :academic_year, presence: true, format: /\d{4}-\d{2}/
  validates :trigger_type, presence: true

  enum trigger_type: [:cpd, :completion]

  scope :active, -> { where(active: true) }
end
