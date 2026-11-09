class UserProgrammeAssessment
  include ProgrammesHelper

  # The first two attempts can be taken back to back. From the second fail
  # onwards, the teacher waits this long after their most recent fail.
  COOL_OFF_PERIOD = 48.hours
  FAILS_BEFORE_COOL_OFF = 2

  def initialize(programme, user)
    @enough_credits_for_test = enough_credits_for_accelerator_test?(user, programme) if programme.assessment
    if @enough_credits_for_test && !programme.user_completed?(user)
      @attempts = programme.assessment.assessment_attempts.for_user(user)
      @failed_attempts = programme.assessment.assessment_attempts.for_user(user).in_state("failed")
    end
  end

  def enough_credits_for_test?
    @enough_credits_for_test
  end

  def total_num_attempts
    return 0 if @attempts.nil?

    @attempts.count
  end

  def failed_num_attempts
    return 0 if @failed_attempts.nil?

    @failed_num_attempts ||= @failed_attempts.count
  end

  def can_take_test_at
    return 0 if @failed_attempts.nil? || @failed_attempts.last.nil? || less_than_two_failed_attempts?

    [@failed_attempts.last.last_transition.created_at.to_i - COOL_OFF_PERIOD.ago.to_i, 0].max
  end

  def latest_attempt
    @latest_attempt ||= @attempts&.last
  end

  def currently_taking_test?
    latest_attempt.present? && latest_attempt.in_state?(:commenced)
  end

  def in_cool_off?
    can_take_test_at != 0
  end

  def can_start_attempt?
    enough_credits_for_test? && !currently_taking_test? && !in_cool_off?
  end

  private

  def less_than_two_failed_attempts?
    failed_num_attempts < FAILS_BEFORE_COOL_OFF
  end

  def enough_credits_for_accelerator_test?(user, programme)
    programme.enough_credits_for_test?(user)
  end
end
