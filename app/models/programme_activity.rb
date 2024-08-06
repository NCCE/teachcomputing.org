class ProgrammeActivity < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  belongs_to :programme_activity_grouping, optional: true

  validates :programme_id, uniqueness: {scope: [:activity_id]}

  after_commit :update_activity_credits, on: :create

  scope :legacy, -> { where(legacy: true) }
  scope :not_legacy, -> { where(legacy: false) }

  def update_activity_credits
    activity.credit = nil
    activity.update_credits
  end
end
