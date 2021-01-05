class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @incomplete_achievements = current_user.achievements.not_in_state(:dropped, :complete)
      .with_courses.order('created_at DESC')
    @completed_achievements = current_user.achievements.in_state(:complete)
      .with_courses.order('updated_at DESC')
    render :show
  end
end
