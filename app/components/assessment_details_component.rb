# frozen_string_literal: true

# The ClassMarker test section of a certificate dashboard. Depending on the
# teacher's attempts it shows the attempt in progress, the cool-off, or what
# the test involves and the form that starts an attempt.
class AssessmentDetailsComponent < ViewComponent::Base
  include ProgrammesHelper

  # Shown under the cool-off message, e.g. where to find help before trying again
  renders_one :cool_off_advice

  # durations are in minutes. leader_confirmation is for tests where a school
  # leader confirms the teacher took the test under exam conditions: it adds a
  # bullet explaining this and a checkbox to confirm they're ready.
  def initialize(user:, assessment:, user_programme_assessment:, duration:, question_count:, extended_duration:, conditions_url:, leader_confirmation: false)
    @user = user
    @assessment = assessment
    @user_programme_assessment = user_programme_assessment
    @duration = duration
    @question_count = question_count
    @extended_duration = extended_duration
    @conditions_url = conditions_url
    @leader_confirmation = leader_confirmation
  end

  private

  def failed_num_attempts
    @user_programme_assessment.failed_num_attempts
  end

  def retry_time
    assessment_time(@user_programme_assessment.retry_at)
  end

  def cool_off_hours
    UserProgrammeAssessment::COOL_OFF_PERIOD.in_hours.to_i
  end
end
