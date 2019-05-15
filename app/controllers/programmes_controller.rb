class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!
  before_action :find_programme!, only: [:show, :complete]
  before_action :user_enrolled?, only: [:show, :complete]
  before_action :passed_programme_assessment?, only: [:complete]

  def show
    render :show
  end
  
  def complete
    render :complete
  end

  private

    def enabled?
      redirect_to root_path unless certification_enabled?
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end

    def user_enrolled?
      redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
    end

    def passed_programme_assessment?
      activities = current_user.achievements.for_programme(@programme).in_state('complete').joins(:activity)
      redirect_to programme_path(@programme.slug) unless activities.where(activities: { category: 'assessment'}).any?
    end
end
