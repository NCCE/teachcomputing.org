class AchievementsController < ApplicationController
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      flash[:notice] = 'Great! Your activity has now been added'
    else
      flash[:error] = 'Whoops something went wrong'
    end

    redirect_to dashboard_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:activity_id)
  end
end
