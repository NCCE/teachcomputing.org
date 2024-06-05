# Plays "ProgrammeObjective" role app/lib/programme_objectives/readme.md
class ProgrammeActivityGrouping < ApplicationRecord
  include ActionView::Helpers::TagHelper
  include StiPreload

  has_many :programme_activities, -> { order(:order) }
  has_many :activities, through: :programme_activities
  belongs_to :programme

  scope :progress_bar_groupings, -> { where.not(progress_bar_title: nil) }
  scope :community, -> { where(community: true) }
  scope :not_community, -> { where(community: false) }

  store_accessor :web_copy, %i[course_requirements], prefix: true

  def user_complete?(user)
    users_completed(users: [user]).values.first
  end

  def formatted_title
    output = title.dup

    completable_activity_count = programme_activities.includes(:activity).where(activity: {coming_soon: false}).count

    if required_for_completion != completable_activity_count
      output << " by completing "
      output << content_tag(:strong, "at least #{required_for_completion.humanize}")
      output << " "
      output << "activity".pluralize(required_for_completion)
    end

    output.html_safe
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

  # Move "Implement selected key stage 3 Teach Computing Curriculum resources" from section 2
  # to section 3 and update the #required_for_completion value on the old grouping
  def self.move_i_belong_section_from_2_to_3
    # Perform the move of the activity to the new grouping
    programme = Programme.find_by(slug: "i-belong")
    raise "Programme could not be found" if programme.blank?

    activity = programme.activities.find_by(title: "Implement selected key stage 3 Teach Computing Curriculum resources")
    raise "Activity could not be found" if activity.blank?

    programme_activity = programme.programme_activities.find_by(activity_id: activity.id)
    raise "Programme activity could not be found" if programme_activity.blank?

    original_grouping = programme.programme_activity_groupings.find_by(sort_key: 3)
    raise "Current grouping could not be found" if original_grouping.blank?

    new_grouping = programme.programme_activity_groupings.find_by(sort_key: 4)
    raise "New grouping could not be found" if new_grouping.blank?

    programme_activity.update!(programme_activity_grouping_id: new_grouping.id)

    # Update the original grouping to only require 2 completed activities
    original_grouping.update!(required_for_completion: 2)
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
