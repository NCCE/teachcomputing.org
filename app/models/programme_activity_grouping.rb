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
    ProgrammeActivityGroupingCompletion.users_completed_completion_counted(
      programme_activity_grouping: self,
      users: [user]
    ).values.first
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
end
