class ProgrammeActivity < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  belongs_to :programme_activity_grouping, optional: true

  validates :programme_id, uniqueness: { scope: [:activity_id] }

  scope :legacy, -> { where(legacy: true) }
  scope :not_legacy, -> { where(legacy: false) }
end
