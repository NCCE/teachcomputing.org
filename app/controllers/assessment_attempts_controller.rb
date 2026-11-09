class AssessmentAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assessment
  before_action :check_attempt_allowed, only: [:create]
  before_action :teacher_reference_number, only: [:create]

  def create
    if @assessment.activity
      achievement = @assessment.activity.achievements.find_or_initialize_by(user_id: params[:assessment_attempt][:user_id])

      unless achievement.save
        flash[:error] = "Failed to create achievement"

        return redirect_back fallback_location: @assessment.programme.path
      end
    end

    assessment_attempt = AssessmentAttempt.new(assessment_attempts_params)

    if assessment_attempt.save
      ExpireAssessmentAttemptJob.set(wait: AssessmentAttempt::EXPIRES_AFTER).perform_later(assessment_attempt)
      redirect_to assessment_url(assessment_attempt.user), allow_other_host: true
    else
      flash[:error] =
        if assessment_attempt&.errors&.any?
          assessment_attempt.errors.full_messages.to_sentence
        else
          "Failed to create assessment attempt"
        end

      redirect_back fallback_location: @assessment.programme.path
    end
  end

  private

  def set_assessment
    @assessment = Assessment.find_by!(id: params[:assessment_attempt][:assessment_id])
  end

  # The dashboards hide the form when an attempt isn't allowed, but an old tab
  # or a direct POST can still reach here
  def check_attempt_allowed
    user_programme_assessment = UserProgrammeAssessment.new(@assessment.programme, current_user)
    return if user_programme_assessment.can_start_attempt?

    flash[:error] = attempt_not_allowed_message(user_programme_assessment)
    redirect_back fallback_location: @assessment.programme.path
  end

  def attempt_not_allowed_message(user_programme_assessment)
    if user_programme_assessment.currently_taking_test?
      expires_at = helpers.assessment_time(user_programme_assessment.latest_attempt.expires_at)
      "You've already started the test. If you didn't finish, you can start a new attempt after #{expires_at}."
    elsif user_programme_assessment.in_cool_off?
      retry_at = helpers.assessment_time(Time.zone.now + user_programme_assessment.can_take_test_at.seconds)
      "You can take the test again after #{retry_at}."
    else
      "You need to complete more courses before you can take the test."
    end
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
