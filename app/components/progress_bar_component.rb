class ProgressBarComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(current_user, programme, title: nil, body: nil)
    @programme = programme
    @title = title
    @body = body

    @programme_objectives = programme.programme_objectives_displayed_in_progress_bar
  end

  def before_render
    @current_user = current_user
  end

  private

  def wide_objective_text_class
    if @programme.show_enrolment_on_progress_bar?
      "progress-bar-component__objective--text"
    else
      "progress-bar-component__objective--text-wide"
    end
  end

  def user_enrolled_class
    if @programme.user_enrolled?(@current_user)
      "icon-ticked-circle"
    else
      "icon-blank-circle"
    end
  end
end
