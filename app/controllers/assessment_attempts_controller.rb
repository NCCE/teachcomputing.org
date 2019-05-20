class AssessmentAttemptsController < ApplicationController
  before_action :set_assessment

  def create
    assessment_attempt = AssessmentAttempt.new(assessment_attempts_params)
    if assessment_attempt.save
      Achievement.create(activity_id: @assessment.activity.id, user_id: params[:assessment_attempt][:user_id])
      ExpireAssessmentAttemptJob.set(wait: 2.hours).perform_later(assessment_attempt)
      redirect_to assessment_url(assessment_attempt.user)
    else
      flash[:error] = 'Whoops something went wrong'
      redirect_to programme_path(@assessment.programme.id)
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
      "#{@assessment.link}?cm_e=#{user.email}&cm_user_id=#{user.id}"
    end
end
