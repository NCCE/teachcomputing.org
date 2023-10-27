class ProgrammeObjectives::AssessmentPassRequired
  attr_reader :progress_bar_title, :progress_bar_path

  def initialize(assessment:, progress_bar_title:, progress_bar_path:)
    @assessment = assessment
    @progress_bar_title = progress_bar_title
    @progress_bar_path = progress_bar_path
  end

  def user_complete?(user)
    assessment.latest_attempt_for(user:)&.in_state?(:passed) || false
  end

  def objective_displayed_in_progress_bar?
    true
  end

  def objective_displayed_in_body?
    false
  end

  private

  attr_reader :assessment
end
