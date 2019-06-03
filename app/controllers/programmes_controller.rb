class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :enabled?
  before_action :authenticate_user!
  before_action :find_programme!, only: [:show, :complete, :certificate]
  before_action :user_enrolled?, only: [:show, :complete, :certificate]
  before_action :list_achievements_by_category, only: [:show, :complete]
  before_action :get_passed_programme_assessment
  before_action :passed_programme_assessment?, only: [:complete, :certificate]
  before_action :get_assessment_state_details, only: [:show]
  before_action :get_certificate_details, only: [:certificate]

  def show
  end

  def complete
  end

  def certificate
    render layout: 'certificate'
  end

  private

    def enabled?
      redirect_to root_path unless certification_enabled?
    end

    def find_programme!
      @programme = Programme.find_by!(slug: params[:slug])
    end

    def list_achievements_by_category
      achievements = current_user.achievements.for_programme(@programme)
      @online_achievements = achievements.with_category('online').take(2)
      @face_to_face_achievements = achievements.with_category('face-to-face').take(2)
      @downloaded_diagnostic = achievements.with_category('action').where(activities: {slug: 'diagnostic-tool'}).any?
    end

    def get_passed_programme_assessment
      @passed_assessment = @programme.passed_programme_assessment?(current_user)
    end

    def get_assessment_state_details
      @enough_credits_for_test = helpers.can_take_accelerator_test?(current_user, @programme)
      @num_attempts = 0
      return if !@enough_credits_for_test || @passed_assessment

      attempts = @programme.assessment.assessment_attempts.where(user_id: current_user.id).order(:created_at)
      @num_attempts = attempts.count
      @can_take_test_at = 0
      @currently_taking_test = false
      if @num_attempts > 0
        last_attempt = attempts.last
        if last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_FAILED.to_s && @num_attempts >= 2
          @can_take_test_at = [last_attempt.state_machine.last_transition.created_at.to_i - 48.hours.ago.to_i, 0].max
        elsif last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_COMMENCED.to_s
          @currently_taking_test = true
        end
      end
    end

    def user_enrolled?
      redirect_to cs_accelerator_path unless @programme.user_enrolled?(current_user)
    end

    def passed_programme_assessment?
      redirect_to programme_path(@programme.slug) unless @passed_assessment
    end

    def get_certificate_details
      passed_assessments = current_user.achievements.for_programme(@programme).in_state('complete').joins(:activity)
        .where(activities: { category: 'assessment'})
      if passed_assessments.any?
        @passed_test_at = passed_assessments.last.state_machine.last_transition.created_at
      end
    end
end
