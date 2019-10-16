class AchievementsController < ApplicationController
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      flash[:notice] = "Great! '#{@achievement.activity.title}' has been added to your Record of Achievement #{view_context.link_to_if(@achievement.activity.self_certifiable?, 'Undo', achievement_path(@achievement.id), method: :delete) {}}"
      metadata = { credit: @achievement.activity.credit }
      if params[:self_verification_info].present?
        metadata[:self_verification_info] =  params[:self_verification_info]
      end
      @achievement.transition_to(:complete, metadata)
    else
      flash[:error] = "Whoops something went wrong adding the activity to your Record of Achievement"
    end

    redirect_to request.referrer || dashboard_path
  end

  def destroy
    begin
      @achievement = Achievement.find_by!(id: params[:id])
      flash[:notice] = "'#{@achievement.activity.title}' has been removed from your Record of Achievement" if @achievement.destroy!
    rescue
      flash[:error] = 'Whoops something went wrong removing the activity from your Record of Achievement'
    end

    redirect_to dashboard_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:activity_id)
  end
end
