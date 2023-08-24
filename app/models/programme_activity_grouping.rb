class ProgrammeActivityGrouping < ApplicationRecord
  include ActionView::Helpers::TagHelper

  has_many :programme_activities, -> { order(:order) }
  belongs_to :programme

  scope :progress_bar_groupings, -> { where.not(progress_bar_title: nil) }
  scope :community, -> { where(community: true) }
  scope :not_community, -> { where(community: false) }

  def achievements(user)
    user.achievements.in_state(:complete).for_programme(programme)
  end

  def user_complete?(user)
    completed_activity_count = 0
    user_achievements = achievements(user).to_a
    programme_activities.each do |programme_activity|
      completed_activity = user_achievements.find { _1.activity_id == programme_activity.activity_id }
      completed_activity_count += 1 if completed_activity
      return true if completed_activity_count >= required_for_completion
    end
    nil
  end

  def formatted_title
    output = title.dup

    completable_activity_count = programme_activities.includes(:activity).where(activity: { coming_soon: false }).count

    if required_for_completion != completable_activity_count
      output << ' by completing '
      output << content_tag(:strong, "at least #{required_for_completion.humanize}")
      output << ' '
      output << 'activity'.pluralize(required_for_completion)
    end

    output.html_safe
  end

  def order_programme_activities_for_user(user)
    pathway = user.user_programme_enrolments.find_by(programme:).pathway

    return programme_activities.legacy unless pathway

    completed_activity_ids = user.achievements.in_state(:complete).pluck(:activity_id)

    completed_non_legacy_activities, non_completed_non_legacy_activities = programme_activities
      .not_legacy
      .joins(activity: :pathway_activities)
      .where(activity: { pathway_activities: { pathway: pathway } } )
      .partition { completed_activity_ids.include?(_1.activity_id) }

    completed_legacy_activities = programme_activities
      .legacy
      .select { completed_activity_ids.include?(_1.activity_id) }

    completed_legacy_activities + completed_non_legacy_activities + non_completed_non_legacy_activities
  end
end
