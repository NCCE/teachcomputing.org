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

  # When the cool-off after the most recent fail ends, or nil if the teacher
  # hasn't failed enough times for a cool-off to apply
  def retry_at
    return @retry_at if defined?(@retry_at)

    @retry_at =
      if before_cool_off_threshold?
        nil
      else
        @failed_attempts.last.last_transition.created_at + COOL_OFF_PERIOD
      end
  end

  # Seconds until the teacher can take the test again, or 0 if they can now
  def can_take_test_at
    return 0 unless in_cool_off?

    (retry_at - Time.zone.now).to_i
  end

  def latest_attempt
    @latest_attempt ||= @attempts&.last
  end

  def currently_taking_test?
    latest_attempt.present? && latest_attempt.in_state?(:commenced)
  end

  def in_cool_off?
    retry_at.present? && retry_at.future?
  end

  def can_start_attempt?
    enough_credits_for_test? && !currently_taking_test? && !in_cool_off?
  end

  private

  def before_cool_off_threshold?
    failed_num_attempts < FAILS_BEFORE_COOL_OFF
  end

  def enough_credits_for_accelerator_test?(user, programme)
    programme.enough_credits_for_test?(user)
  end
end
