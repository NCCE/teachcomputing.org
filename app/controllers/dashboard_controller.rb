class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
	# before_action :user_enrolled?

  def show
    @achievements = current_user.achievements.in_state(:complete)
                                .without_category('action').order('created_at ASC')
    render :show
  end
end
