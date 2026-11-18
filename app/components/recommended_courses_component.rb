# frozen_string_literal: true

class RecommendedCoursesComponent < ViewComponent::Base
  VISIBLE_COUNT = 2

  # Shown to the right of the title, e.g. a link to the pathway PDF. Links
  # can't go in the title, because the title is the toggle button.
  renders_one :description

  attr_reader :current_user, :programme, :pathway, :event_category

  def initialize(current_user:, programme:, pathway:, recommended_activities:, event_category:, start_expanded: true)
    @current_user = current_user
    @programme = programme
    @pathway = pathway
    @activities = Array(recommended_activities)
    @event_category = event_category
    @start_expanded = start_expanded
  end

  def show_courses?
    pathway.present?
  end

  def title
    "#{course_count} #{"course".pluralize(course_count)} based on your pathway"
  end

  def course_count
    @activities.size
  end

  def visible_activities
    @activities.first(VISIBLE_COUNT)
  end

  def extra_activities
    @activities.drop(VISIBLE_COUNT)
  end

  def expandable?
    show_courses? && extra_activities.any?
  end

  def start_expanded?
    @start_expanded
  end

  def courses_id
    "recommended-courses-#{pathway.id}"
  end

  def wrapper_data
    expandable? ? {controller: "expander"} : {}
  end

  def toggle_button_data
    {
      action: "expander#toggleAll",
      expander_target: "expanderButton",
      event_action: "click",
      event_label: "Show all recommended courses",
      event_category:
    }
  end

  def all_courses_link
    link_to "Browse all certificate courses",
      courses_path(certificate: programme.slug),
      class: "govuk-button button--inverted button govuk-!-margin-bottom-0",
      data: {event_action: "click", event_category:, event_label: "View all certificate courses"}
  end
end
