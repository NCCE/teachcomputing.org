class AchievementsController < ApplicationController
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      flash[:notice] = "Great! '#{@achievement.activity.title}' has been added"
      metadata = { credit: @achievement.activity.credit }
      if params[:self_verification_info].present?
        metadata[:self_verification_info] =  params[:self_verification_info]
      end
      @achievement.transition_to(:complete, metadata)
      if @achievement.activity.programmes.include?(Programme.primary_certificate)
        PrimaryCertificatePendingTransitionJob.perform_later(current_user.id, source: 'AchievementsController.create')
      end
    else
      flash[:error] = 'Whoops something went wrong adding the activity'
    end

    redirect_to self_verification_url || dashboard_path
  end

  def destroy
    begin
      @achievement = Achievement.find_by!(id: params[:id])
      flash[:notice] = "'#{@achievement.activity.title}' has been removed" if @achievement.destroy!
    rescue
      flash[:error] = 'Whoops something went wrong removing the activity'
    end

    redirect_to dashboard_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:activity_id)
  end

  def self_verification_url
    helpers.whitelist_redirect_url(request.referrer)
  end
end
