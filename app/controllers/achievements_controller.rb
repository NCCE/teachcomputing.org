class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_achievement, only: %i[destroy update]

  def create
    @achievement = current_user.achievements.build(achievement_params)

    if @achievement.save && @achievement.transition_to(:drafted)
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"

      return render json: {}, status: 200
    else
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Sorry something went wrong saving your progress#{specifics}"

      return render  json: {}, status: 422
    end
  end

  def update
    if @achievement.update(achievement_params)
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"

      return render json: {}, status: 200
    else
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Sorry something went wrong saving your progress#{specifics}"

      return render json: {}, status: 422
    end
  end

  def destroy
    begin
      flash[:notice] = "'#{@achievement.activity.title}' has been removed" if @achievement.destroy!

      return render json: {}, status: 200
    rescue StandardError
      flash[:error] = 'Whoops something went wrong removing the activity'

      return render json: {}, status: 422
    end
  end

  def submit
    @achievement = current_user
      .achievements
      .create_with(achievement_params)
      .find_or_create_by(activity_id: achievement_params[:activity_id])

    unless @achievement.persisted?
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Whoops something went wrong#{specifics}"

      return render json: {}, status: 422
    end

    unless @achievement.adequate_evidence_provided?
      flash[:notice] = 'Inadequate evidence provided'

      return render json: {}, status: 422
    end

    @achievement.transition_community_to_complete
    CertificatePendingTransitionJob.perform_now(current_user, { source: 'AchievementsController.create' })

    flash[:notice] = "'#{@achievement.activity.title}' was succesfully submitted"

    return render json: {}, status: 200
  end

  private

    def set_achievement
      @achievement = current_user.achievements.find(params[:id])
    end

    def achievement_params
      params.require(:achievement).permit(:activity_id, :supporting_evidence, :self_verification_info)
    end

    def self_verification_url
      helpers.safe_redirect_url(request.referrer) || dashboard_path
    end
end
