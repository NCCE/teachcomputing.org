class ProgrammeActivity < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  belongs_to :programme_activity_grouping, optional: true

  validates :programme_id, uniqueness: { scope: [:activity_id] }

  delegate :title, :stem_activity_code, :slug, :category, :online?, :remote_delivered_cpd?, to: :activity
end
