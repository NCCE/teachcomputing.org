class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!

  before_action :find_programme!, :set_achievements_complete, only: [:show]


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

    def set_achievements_complete
      programme = Programme.find_by!(slug: params[:slug])
      @achievements = current_user.achievements.for_programme(programme).joins(:activity)
      @online_achievements = current_user.achievements.for_programme(programme).joins(:activity).with_category('online')
      @face_to_face_achievements = current_user.achievements.for_programme(programme).joins(:activity).with_category('face-to-face')
      @action_achievements = current_user.achievements.for_programme(programme).joins(:activity).with_category('action')
    end
end
