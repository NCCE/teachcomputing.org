class ProgressBarComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(current_user, programme, title: nil, body: nil, steps_to_accreditation: true)
    @programme = programme
    @title = title
    @body = body
    @top_padding = top_padding
    @steps_to_accreditation = steps_to_accreditation

    @programme_objectives = programme.programme_objectives_displayed_in_progress_bar
  end

  def before_render
    @current_user = current_user

    in_progress_achievements = current_user.achievements.in_state(:in_progress, :enrolled).with_courses.order("created_at DESC")
    complete_achievements = current_user.achievements.in_state(:complete).with_courses.order("created_at DESC")

    @courses =
      {
        in_progress: in_progress_achievements.belonging_to_programme(@programme),
        complete: complete_achievements.belonging_to_programme(@programme)
      }
  end

  def user_enrolled_class
    if @programme.user_enrolled?(@current_user)
      "icon-ticked-circle"
    else
      "icon-blank-circle"
    end
  end

  def course_status_class(status)
    if @courses[status].blank?
      "icon-blank-circle"
    elsif @courses[status].present?
      "icon-pending-circle"
    end
  end
end
