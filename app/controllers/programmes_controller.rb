class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!

  before_action :find_programme!, :list_achievements_by_category, only: [:show]


  def show
    if @programme.user_enrolled?(current_user)
      render :show
    else
      redirect_to certification_path
    end
  end

  private

    def enabled?
      redirect_to root_path unless certification_enabled?
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end

    def list_achievements_by_category
      @online_achievements = current_user.achievements.for_programme(@programme)
        .with_category('online')
      @face_to_face_achievements = current_user.achievements.for_programme(@programme)
        .with_category('face-to-face')
      @downloaded_diagnostic = current_user.achievements.for_programme(@programme)
        .with_category('action').where(activities: {slug: 'downloaded-diagnostic-tool'}).any?
    end
end
