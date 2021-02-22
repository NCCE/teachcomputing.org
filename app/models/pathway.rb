class Pathway < ApplicationRecord
  belongs_to :programme
  has_many   :user_programme_enrolments
  has_many   :pathway_activities, dependent: :destroy

  scope :ordered, -> { order('pathways.order') }

  def recommended_activities
    pathway_activities.where(supplementary: false)
  end

  def supplementary_activities
    pathway_activities.where(supplementary: true)
  end

  def recommended_courses
    activity_codes = recommended_activities.map { |pa| pa.activity.stem_activity_code }
    Achiever::Course::Template.find_many_by_activity_codes(activity_codes)
  end
end
