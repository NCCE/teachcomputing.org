class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements

    render :show
  end

  def assessment
    render :assessment
  end
end
