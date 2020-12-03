class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements.not_in_state(:dropped)
                                .with_courses.order('created_at ASC')
    render :show
  end
end
