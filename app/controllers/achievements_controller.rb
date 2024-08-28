class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_achievement, only: %i[destroy update]

  def create
    @achievement = current_user.achievements.build(achievement_params)

    if @achievement.save && @achievement.transition_to(:drafted)
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"

      render json: {}, status: 200
    else
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Sorry something went wrong saving your progress#{specifics}"

      render json: {}, status: 422
    end
  end

  def update
    if @achievement.update(achievement_params)
      flash[:notice] = "'#{@achievement.activity.title}' progress has been saved"

      render json: {}, status: 200
    else
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Sorry something went wrong saving your progress#{specifics}"

      render json: {}, status: 422
    end
  end

  def destroy
    flash[:notice] = "'#{@achievement.activity.title}' has been removed" if @achievement.destroy!

    render json: {}, status: 200
  rescue
    flash[:error] = "Whoops something went wrong removing the activity"

    render json: {}, status: 422
  end

  def submit
    @achievement = current_user
      .achievements
      .find_or_initialize_by(activity_id: achievement_params[:activity_id])

    @achievement.assign_attributes(achievement_params)

    unless @achievement.save
      specifics = ": #{@achievement.errors.full_messages.to_sentence}" if @achievement.errors.present?
      flash[:error] = "Whoops something went wrong#{specifics}"

      return render json: {}, status: 422
    end

    unless @achievement.adequate_evidence_provided?
      flash[:notice] = "Inadequate evidence provided"

      return render json: {}, status: 422
    end

    @achievement.transition_community_to_complete
    CertificatePendingTransitionJob.perform_now(current_user, {source: "AchievementsController.create"})

    flash[:notice] = "'#{@achievement.activity.title}' was succesfully submitted"

    render json: {}, status: 200
  end

  private

  def set_achievement
    @achievement = current_user.achievements.find(params[:id])
  end

  def achievement_params
    params.require(:achievement).permit(:activity_id, :supporting_evidence,
      :submission_option, evidence: [])
  end
end
