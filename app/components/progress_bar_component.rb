class ProgressBarComponent < ViewComponent::Base
    def initialize(current_user, programme, title: nil, body: nil, steps_to_accreditation: true)
      @programme = programme
      @current_user = current_user
      @title = title
      @body = body
      @steps_to_accreditation = steps_to_accreditation

      @programme_activity_groupings = @programme.programme_activity_groupings.progress_bar_groupings
    end
  end
