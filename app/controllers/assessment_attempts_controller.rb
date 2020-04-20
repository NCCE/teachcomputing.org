class AssessmentAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assessment
  before_action :teacher_reference_number, only: [:create]

  def create
    assessment_attempt = AssessmentAttempt.new(assessment_attempts_params)
    achievement = @assessment.activity.achievements.find_or_initialize_by(user_id: params[:assessment_attempt][:user_id])
    if assessment_attempt.valid? && achievement.valid?
      assessment_attempt.save
      achievement.save
      ExpireAssessmentAttemptJob.set(wait: 2.hours).perform_later(assessment_attempt)
      redirect_to assessment_url(assessment_attempt.user)
    else
      flash[:error] = 'Whoops something went wrong'
      redirect_to programme_path(@assessment.programme.slug)
    end
  end

  private

    def set_assessment
      @assessment = Assessment.find_by!(id: params[:assessment_attempt][:assessment_id])
    end

    def assessment_attempts_params
      params.require(:assessment_attempt).permit(:assessment_id, :user_id)
    end

    def assessment_url(user)
      "#{@assessment.link}&cm_e=#{user.email}&cm_user_id=#{user.id}"
    end

    def teacher_reference_number
      trn = params.fetch(:user, {})[:teacher_reference_number]
      current_user.update_attributes(teacher_reference_number: trn) if trn.present?
    end
end
