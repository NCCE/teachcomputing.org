class ProgressBarComponent < ViewComponent::Base
    def initialize(current_user, programme)
      @programme = programme
      @current_user = current_user

      @programme_activity_groupings = @programme.programme_activity_groupings.progress_bar_groupings
    end
  end
