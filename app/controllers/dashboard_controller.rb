class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :set_programmes

  def show
    @achievements = current_user.achievements.in_state(:complete).order('created_at ASC')
    @certification_enabled = certification_enabled?
    render :show
  end

  private

    def set_programmes
      @programmes = Programme.all if certification_enabled?
    end
end
