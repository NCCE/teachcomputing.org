require "administrate/field/base"

class AssessmentDetailsField < Administrate::Field::Base
  def assessment_display
    "Name: #{assessment.programme.title} assessment (created #{assessment_created_at})"
  end

  def attempted_at_display
    "State last changed on: #{state_last_changed_at}"
  end

  def percentage_score_display
    "Score: #{percentage_score}"
  end

  private

  def assessment_attempt
    @assessment_attempt ||= resource
  end

  def assessment
    @assessment ||= assessment_attempt.assessment
  end

  def assessment_created_at
    assessment.created_at.strftime("%d/%m/%Y %H:%M")
  end

  def state_last_changed_at
    assessment_attempt.last_transition&.created_at&.strftime("%d/%m/%Y %H:%M") || "No changes yet"
  end

  def percentage_score
    score_data = assessment_attempt.last_transition&.metadata&.dig("percentage").presence
    score_data ? "#{score_data}%" : "-"
  end
end
