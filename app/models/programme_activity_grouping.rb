# Plays "ProgrammeObjective" role app/lib/programme_objectives/readme.md
class ProgrammeActivityGrouping < ApplicationRecord
  include ActionView::Helpers::TagHelper

  has_many :programme_activities, -> { order(:order) }
  has_many :activities, through: :programme_activities
  belongs_to :programme

  scope :progress_bar_groupings, -> { where.not(progress_bar_title: nil) }
  scope :community, -> { where(community: true) }
  scope :not_community, -> { where(community: false) }

  store_accessor :web_copy, %i[course_requirements aside_slug subtitle step_number], prefix: true
  store_accessor :objectives, %i[progress_bar_stages], prefix: true

  validates :cms_slug, uniqueness: true

  def user_complete?(user)
    users_completed(users: [user]).values.first
  end

  def objective_displayed_in_progress_bar?
    true
  end

  def objective_displayed_in_body?
    true
  end

  def progress_bar_path
    "##{id}"
  end

  def multi_stage_objectives
    objectives_progress_bar_stages
  end

  # completion counted
  def users_completed(users:)
    users_achievement_activity_ids = fetch_users_achievement_activity_ids(users:)

    activities = programme_activities.includes(:activity).map(&:activity)

    users.map do |user|
      completed_activity_count = activities
        .count { _1.id.in?(users_achievement_activity_ids[user.id] || []) }

      [user.id, completed_activity_count >= required_for_completion]
    end.to_h
  end

  protected def fetch_users_achievement_activity_ids(users:)
    Achievement
      .in_state(:complete)
      .belonging_to_programme(programme)
      .joins(activity: :programme_activities)
      .where(
        activities: {programme_activities: {legacy: false}},
        user: users
      )
      .group_by(&:user_id)
      .transform_values { _1.map(&:activity_id) }
  end
end
