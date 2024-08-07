class UserProgrammeAssessment
  include ProgrammesHelper

  def initialize(programme, user)
    @enough_credits_for_test = false
    @enough_credits_for_test = can_take_accelerator_test?(user, programme) if programme.assessment
    @enough_activities_for_test = enough_activities_for_accelerator_test?(user, programme) if programme.assessment
    if @enough_credits_for_test && !programme.user_completed?(user)
      @attempts = programme.assessment.assessment_attempts.for_user(user)
    end
  end

  def enough_credits_for_test?
    @enough_credits_for_test
  end

  def enough_activities_for_test?
    @enough_activities_for_test
  end

  def num_attempts
    return 0 if @attempts.nil? || @attempts&.last&.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_TIMEDOUT.to_s

    @attempts.count
  end

  def can_take_test_at
    return 0 if @attempts.nil? || @attempts.last.nil? || less_than_two_failed_attempts?

    [@attempts.last.last_transition.created_at.to_i - 48.hours.ago.to_i, 0].max
  end

  def currently_taking_test?
    return false if @attempts.nil? || @attempts.last.nil?

    @attempts.last.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_COMMENCED.to_s
  end

  private

  def less_than_two_failed_attempts?
    @attempts.last.current_state != StateMachines::AssessmentAttemptStateMachine::STATE_FAILED.to_s || num_attempts < 2
  end

  def can_take_accelerator_test?(user, programme)
    programme.credits_achieved_for_certificate(user) >= programme.max_credits_for_certificate
  end

  def enough_activities_for_accelerator_test?(user, programme)
    programme.enough_activities_for_test?(user)
  end
end
