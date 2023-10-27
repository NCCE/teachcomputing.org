class Assessment < ApplicationRecord
  belongs_to :programme
  belongs_to :activity, optional: true
  has_many   :assessment_attempts, dependent: :destroy

  validates :class_marker_test_id, :link, presence: true

  def latest_attempt_for(user:)
    user.assessment_attempts.where(assessment: self).order(:created_at).last
  end
end
