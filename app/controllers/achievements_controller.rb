class AchievementsController < ApplicationController
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      flash[:notice] = "Great! Your activity has now been added #{view_context.link_to('Undo', achievement_path(@achievement.id), method: :delete)}"
    else
      flash[:error] = 'Whoops something went wrong'
    end

    redirect_to dashboard_path
  end

  def destroy
    @achievement = Achievement.find_by(id: params[:id])

    if @achievement.destroy
      flash[:notice] = "Your activity has been removed"
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
