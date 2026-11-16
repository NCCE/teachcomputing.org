# frozen_string_literal: true

class RecommendedCoursesComponent < ViewComponent::Base
  VISIBLE_COUNT = 2

  attr_reader :current_user, :programme, :pathway, :event_category

  def initialize(current_user:, programme:, pathway:, recommended_activities:, event_category:, title: nil, start_expanded: true)
    @current_user = current_user
    @programme = programme
    @pathway = pathway
    @activities = Array(recommended_activities)
    @event_category = event_category
    @title = title
    @start_expanded = start_expanded
  end

  def show_courses?
    pathway.present?
  end

  def title
    @title || "Courses based on your pathway"
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

  def expand_label
    "Show all #{@activities.size} courses"
  end

  def collapse_label
    "Show fewer courses"
  end

  def toggle_label
    start_expanded? ? collapse_label : expand_label
  end

  def wrapper_data
    return {} unless expandable?

    {
      controller: "expander",
      expander_expand_value: expand_label,
      expander_collapse_value: collapse_label
    }
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
