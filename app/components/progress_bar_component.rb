class ProgressBarComponent < Cms::WithAsidesComponent
  # Icon status classes
  ICON_BLANK_CIRCLE_CLASS = "icon-blank-circle".freeze
  ICON_TICKED_CIRCLE_CLASS = "icon-ticked-circle".freeze
  ICON_PENDING_CIRCLE_CLASS = "icon-pending-circle".freeze

  delegate :current_user, to: :helpers

  def initialize(programme:, aside_slug: nil, title: nil, body: nil, background_color: "light-grey")
    aside_sections = if aside_slug.nil?
      nil
    else
      [{slug: aside_slug}]
    end

    super(aside_sections:)
    @programme = programme
    @title = title
    @body = body
    @background_color = background_color

    @programme_objectives = programme.programme_objectives_displayed_in_progress_bar
  end

  private

  def content_spacing_class(class_name)
    return class_name unless @programme.show_extra_objectives_on_progress_bar?

    "#{class_name}-extra-objective-spacing"
  end

  def user_enrolled_class
    return ICON_TICKED_CIRCLE_CLASS if @programme.user_enrolled?(current_user)

    ICON_BLANK_CIRCLE_CLASS
  end

  def course_bookings_status_class(objective, state)
    current_state = objective.course_credit_state(current_user, state)

    icon_class = case current_state
    when :required_credits
      ICON_TICKED_CIRCLE_CLASS
    when :missing_credits
      ICON_PENDING_CIRCLE_CLASS
    else
      ICON_BLANK_CIRCLE_CLASS
    end

    "progress-bar-component__objective--icon #{icon_class}"
  end

  def programme_objective_status_class(objective)
    classes = ["progress-bar-component__objective--icon"]
    classes << if objective.user_complete?(current_user)
      ICON_TICKED_CIRCLE_CLASS
    else
      ICON_BLANK_CIRCLE_CLASS
    end
    classes.join(" ")
  end
end
