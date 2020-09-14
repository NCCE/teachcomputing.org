class AchievementsController < ApplicationController
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      flash[:notice] = "Great! '#{@achievement.activity.title}' has been added"
      metadata = { credit: @achievement.activity.credit }
      if params[:self_verification_info].present?
        metadata[:self_verification_info] = params[:self_verification_info]
      end
      @achievement.transition_to(:complete, metadata)

      if @achievement.programme
        case @achievement.programme.slug
        when 'cs-accelerator'
          AssesmentEligibilityJob.perform_now(current_user.id, source: 'AchievementsController.create')
        when 'primary-certificate'
          PrimaryCertificatePendingTransitionJob.perform_now(current_user.id, source: 'AchievementsController.create')
        end
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
    rescue StandardError
      flash[:error] = 'Whoops something went wrong removing the activity'
    end

    redirect_to dashboard_path
  end

  private

    def achievement_params
      params.require(:achievement).permit(:activity_id)
    end

    def self_verification_url
      helpers.safe_redirect_url(request.referrer)
    end
end
