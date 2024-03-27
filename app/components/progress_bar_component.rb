class ProgressBarComponent < ViewComponent::Base
  def initialize(current_user, programme, title: nil, body: nil, steps_to_accreditation: true)
    @programme = programme
    @current_user = current_user
    @title = title
    @body = body
    @steps_to_accreditation = steps_to_accreditation

    @programme_objectives = programme.programme_objectives_displayed_in_progress_bar
  end
end
