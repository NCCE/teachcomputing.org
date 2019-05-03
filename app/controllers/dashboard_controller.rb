class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements.in_state(:complete).order('created_at ASC')
    render :show
  end
end
