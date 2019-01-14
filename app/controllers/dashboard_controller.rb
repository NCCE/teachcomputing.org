class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    render :show
  end
end
