# Plays role "ProgrammeObjective" and "ProgressBarItem"
class ProgrammeObjectives::ProgrammeCompletionRequired
  attr_reader :progress_bar_title, :progress_bar_path

  def initialize(required_programme:, progress_bar_title:, progress_bar_path:)
    @required_programme = required_programme
    @progress_bar_title = progress_bar_title
    @progress_bar_path = progress_bar_path
  end

  def user_complete?(user)
    required_programme.user_completed?(user)
  end

  def objective_displayed_in_progress_bar?
    true
  end

  def objective_displayed_in_body?
    false
  end

  private

  attr_reader :required_programme
end
