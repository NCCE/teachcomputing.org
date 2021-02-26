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
end
