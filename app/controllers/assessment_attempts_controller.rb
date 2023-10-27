class AssessmentAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assessment
  before_action :teacher_reference_number, only: [:create]

  def create
    if @assessment.activity
      achievement = @assessment.activity.achievements.find_or_initialize_by(user_id: params[:assessment_attempt][:user_id])

      unless achievement.save
        flash[:error] = 'Failed to create achievement'

        return redirect_back fallback_location: @assessment.programme.path
      end
    end

    assessment_attempt = AssessmentAttempt.new(assessment_attempts_params)

    if assessment_attempt.save
      ExpireAssessmentAttemptJob.set(wait: 2.hours).perform_later(assessment_attempt)
      redirect_to assessment_url(assessment_attempt.user)
    else
      flash[:error] =
        if assessment_attempt&.errors&.any?
          assessment_attempt.errors.full_messages.to_sentence
        else
          'Failed to create assessment attempt'
        end

      redirect_back fallback_location: @assessment.programme.path
    end
  end

  private

    def set_assessment
      @assessment = Assessment.find_by!(id: params[:assessment_attempt][:assessment_id])
    end

    def assessment_attempts_params
      params.require(:assessment_attempt).permit(:assessment_id, :user_id, :accepted_conditions)
    end

    def assessment_url(user)
      "#{@assessment.link}&cm_e=#{user.email}&cm_user_id=#{user.id}"
    end

    def teacher_reference_number
      trn = params.fetch(:user, {})[:teacher_reference_number]
      current_user.update(teacher_reference_number: trn) if trn.present?
    end
end
