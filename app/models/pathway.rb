class Pathway < ApplicationRecord
  belongs_to :programme
  has_many :user_programme_enrolments
  has_many :pathway_activities, dependent: :destroy

  store_accessor :web_copy, %i[improvement_bullets improvement_cta enrol_copy]

  scope :ordered_by_programme, lambda { |programme_slug|
    where(programme_id: Programme.find_by_slug(programme_slug)).order("pathways.order")
  }

  scope :not_legacy, -> { where(legacy: false) }

  def has_improvement_copy?
    improvement_bullets.present? && improvement_cta.present?
  end

  def recommended_activities
    pathway_activities.includes(activity: :replaced_by)
  end

  def recommended_activities_for_user(user)
    user_activity_ids = user.achievements.map(&:activity_id)
    recommended_activities.where.not(activity_id: user_activity_ids)
  end
end
