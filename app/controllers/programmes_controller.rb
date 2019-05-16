class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!
  before_action :find_programme!, only: [:show, :complete]
  before_action :user_enrolled?, only: [:show, :complete]
  before_action :list_achievements_by_category, only: [:show]
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

    def list_achievements_by_category
      achievements = current_user.achievements.for_programme(@programme)
      @online_achievements = achievements.with_category('online').take(2)
      @face_to_face_achievements = achievements.with_category('face-to-face').take(2)
      @downloaded_diagnostic = achievements.with_category('action').where(activities: {slug: 'downloaded-diagnostic-tool'}).any?
    end

    def user_enrolled?
      redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
    end

    def passed_programme_assessment?
      redirect_to programme_path(@programme.slug) unless @programme.passed_programme_assessment?(current_user)
    end
end
