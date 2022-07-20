class Pathway < ApplicationRecord
  belongs_to :programme
  has_many   :user_programme_enrolments
  has_many   :pathway_activities, dependent: :destroy

  scope :ordered_by_programme, lambda { |programme_slug|
    where(programme_id: Programme.find_by_slug(programme_slug)).order('pathways.order')
  }

  def recommended_activities
    pathway_activities.where(supplementary: false)
  end

  def supplementary_activities
    pathway_activities.where(supplementary: true)
  end

  def recommended_activities_for_user(user)
    user_activity_ids = user.achievements.map(&:activity_id)
    recommended_activities.where.not(activity_id: user_activity_ids)
  end

  def supplementary_activities_for_user(user)
    user_activity_ids = user.achievements.map(&:activity_id)
    supplementary_activities.where.not(activity_id: user_activity_ids)
  end
end
