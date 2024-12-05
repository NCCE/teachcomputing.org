class ProgressBarComponent < ViewComponent::Base
  def initialize(current_user, programme, title: nil, body: nil, top_padding: true, steps_to_accreditation: true)
    @programme = programme
    @current_user = current_user
    @title = title
    @body = body
    @top_padding = top_padding
    @steps_to_accreditation = steps_to_accreditation

    @programme_objectives = programme.programme_objectives_displayed_in_progress_bar
  end

  def top_padding_class
    if @top_padding
      "govuk-!-padding-top-3"
    end
  end
end
