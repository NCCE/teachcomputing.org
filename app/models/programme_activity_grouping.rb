# Plays "ProgrammeObjective" role app/lib/programme_objectives/readme.md
class ProgrammeActivityGrouping < ApplicationRecord
  include ActionView::Helpers::TagHelper
  include StiPreload

  has_many :programme_activities, -> { order(:order) }
  belongs_to :programme

  scope :progress_bar_groupings, -> { where.not(progress_bar_title: nil) }
  scope :community, -> { where(community: true) }
  scope :not_community, -> { where(community: false) }

  store_accessor :web_copy, %i[body_heading course_requirements], prefix: true

  def achievements(user)
    user.achievements.in_state(:complete).belonging_to_programme(programme)
  end

  def user_complete?(user)
    user_achievement_activity_ids = achievements(user).pluck(:activity_id)

    completed_activity_count = programme_activities
      .count { _1.activity_id.in? user_achievement_activity_ids }

    completed_activity_count >= required_for_completion
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

  def order_programme_activities_for_user(user, pathway)
    return programme_activities.legacy unless pathway

    completed_activity_ids = user.achievements.in_state(:complete).pluck(:activity_id)

    completed_non_legacy_activities = []
    non_completed_non_legacy_activities = []

    programme_activities
      .not_legacy
      .includes(activity: :pathway_activities)
      .each do |programme_activity|
        completed = completed_activity_ids.include?(programme_activity.activity_id)

        next completed_non_legacy_activities << programme_activity if completed

        belongs_to_pathway = programme_activity
          .activity
          .pathway_activities
          .any? { _1.pathway_id == pathway.id }

        next non_completed_non_legacy_activities << programme_activity if belongs_to_pathway
      end

    completed_legacy_activities = programme_activities
      .legacy
      .select { completed_activity_ids.include?(_1.activity_id) }

    completed_legacy_activities + completed_non_legacy_activities + non_completed_non_legacy_activities
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

  def body_component
    if community
      CommunityActivityGroupingComponent
    else
      NonCommunityActivityGroupingComponent
    end
  end
end
