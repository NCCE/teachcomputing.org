class ProgrammeObjectives::AssessmentPassRequired
  def initialize(assessment:)
    @assessment = assessment
  end

  def user_complete?(user)
    assessment.latest_attempt_for(user:)&.in_state?(:passed) || false
  end

  def objective_displayed_in_progress_bar?
    false
  end

  def objective_displayed_in_body?
    false
  end

  private

  attr_reader :assessment
end
