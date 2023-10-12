class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_achievement, only: %i[destroy update]

  def create
    @achievement = current_user.achievements.build(achievement_params)

    if @achievement.save
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"
    else
      flash[:error] =
        if @achievement.errors.present?
          @achievement.errors.full_messages.to_sentence
        else
          'Sorry something went wrong saving your progress'
        end
    end

    redirect_to self_verification_url
  end

  def update
    if @achievement.update(achievement_params)
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"
    else
      flash[:error] =
        if @achievement.errors.present?
          @achievement.errors.full_messages.to_sentence
        else
          'Sorry something went wrong saving your progress'
        end
    end

    redirect_to self_verification_url
  end

  def destroy
    begin
      flash[:notice] = "'#{@achievement.activity.title}' has been removed" if @achievement.destroy!
    rescue StandardError
      flash[:error] = 'Whoops something went wrong removing the activity'
    end

    redirect_to self_verification_url
  end

  def submit
    @achievement = current_user
      .achievements
      .create_with(achievement_params)
      .find_or_create_by(activity_id: achievement_params[:activity_id])

    unless @achievement.persisted?
      flash[:error] =
        if @achievement.errors.present?
          @achievement.errors.full_messages.to_sentence
        else
          'Whoops something went wrong'
        end

      return redirect_to self_verification_url
    end

    unless @achievement.adequate_evidence_provided?
      flash[:notice] = 'Inadequate evidence provided'

      return redirect_to self_verification_url
    end

    @achievement.transition_community_to_complete
    CertificatePendingTransitionJob.perform_now(current_user, { source: 'AchievementsController.create' })

    flash[:notice] = "'#{@achievement.activity.title}' was succesfully submitted"
    redirect_to self_verification_url
  end

  private

    def set_achievement
      @achievement = current_user.achievements.find(params[:id])
    end

    def achievement_params
      params.require(:achievement).permit(:id, :activity_id, :supporting_evidence, :self_verification_info)
    end

    def self_verification_url
      helpers.safe_redirect_url(request.referrer) || dashboard_path
    end
end
