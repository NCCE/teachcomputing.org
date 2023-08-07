class ProgressBarComponent < ViewComponent::Base
    def initialize(current_user, programme)
      @programme = programme
      @current_user = current_user
    end
  end