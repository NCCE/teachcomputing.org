class DashboardController < ApplicationController
  def show
    @achievements = current_user.achievements
    
    render :show
  end
end
