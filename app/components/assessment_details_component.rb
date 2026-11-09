# frozen_string_literal: true

# The "Ready to take your test?" part of a certificate dashboard: what the
# ClassMarker test involves, and the form that starts an attempt.
class AssessmentDetailsComponent < ViewComponent::Base
  # Shown between the heading and the test details, e.g. how many attempts the
  # teacher has used
  renders_one :notice

  # durations are in minutes. confirm_ready adds a second checkbox in which the
  # teacher confirms they're ready to start under exam conditions.
  def initialize(user:, assessment:, duration:, question_count:, extended_duration:, conditions_url:, confirm_ready: false)
    @user = user
    @assessment = assessment
    @duration = duration
    @question_count = question_count
    @extended_duration = extended_duration
    @conditions_url = conditions_url
    @confirm_ready = confirm_ready
  end
end
