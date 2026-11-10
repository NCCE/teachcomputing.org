# frozen_string_literal: true

# The "Ready to take your test?" part of a certificate dashboard: what the
# ClassMarker test involves, and the form that starts an attempt.
class AssessmentDetailsComponent < ViewComponent::Base
  # Shown between the heading and the test details, e.g. how many attempts the
  # teacher has used
  renders_one :notice

  # durations are in minutes. leader_confirmation is for tests where a school
  # leader confirms the teacher took the test under exam conditions: it adds a
  # bullet explaining this and a checkbox to confirm they're ready.
  def initialize(user:, assessment:, duration:, question_count:, extended_duration:, conditions_url:, leader_confirmation: false)
    @user = user
    @assessment = assessment
    @duration = duration
    @question_count = question_count
    @extended_duration = extended_duration
    @conditions_url = conditions_url
    @leader_confirmation = leader_confirmation
  end
end
