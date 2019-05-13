class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!
  before_action :find_programme!, :achievements_completed_by_the_user, only: [:show]

  def show
    if @programme.user_enrolled?(current_user)
      render :show
    else
      redirect_to certification_path
    end
  end

  def achievements_completed_by_the_user?(user, category = 'online')
    programme = Programme.find_by!(slug: 'cs-accelerator')
    activities = user.achievements.for_programme(programme).joins(:activity).where(activities: { category: category})
    yield activities
  end

  private

    def enabled?
      redirect_to root_path unless certification_enabled?
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end
end
