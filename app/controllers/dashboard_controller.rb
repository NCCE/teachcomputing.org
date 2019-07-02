class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :set_programmes

  def show
    @achievements = current_user.achievements.in_state(:complete)
                                .without_category('action').order('created_at ASC')
    render :show
  end

  private

    def set_programmes
      @programmes = Programme.all
    end
end
