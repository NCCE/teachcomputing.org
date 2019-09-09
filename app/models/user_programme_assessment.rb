class UserProgrammeAssessment
  include ProgrammesHelper

  attr_reader :enough_credits_for_test
  attr_reader :num_attempts
  attr_reader :can_take_test_at
  attr_reader :currently_taking_test

  def initialize(programme, user)
    @enough_credits_for_test = false
    return unless programme.assessment

    @enough_credits_for_test = can_take_accelerator_test?(user, programme)
    return if !@enough_credits_for_test || programme.user_completed?(user)

    attempts = programme.assessment.assessment_attempts.for_user(user)
    @num_attempts = attempts.count
    @can_take_test_at = 0
    @currently_taking_test = false

    return unless @num_attempts.positive?

    last_attempt = attempts.last
    if last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_FAILED.to_s && @num_attempts >= 2
      @can_take_test_at = [last_attempt.last_transition.created_at.to_i - 48.hours.ago.to_i, 0].max
    elsif last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_COMMENCED.to_s
      @currently_taking_test = true
    end
  end
end
