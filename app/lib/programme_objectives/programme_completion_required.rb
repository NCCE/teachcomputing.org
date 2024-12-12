# Plays role "ProgrammeObjective" and "ProgressBarItem"
class ProgrammeObjectives::ProgrammeCompletionRequired
  attr_reader :progress_bar_title, :progress_bar_path, :multi_stage_group

  def initialize(required_programme:, progress_bar_title:, progress_bar_path:, multi_stage_group: false)
    @required_programme = required_programme
    @progress_bar_title = progress_bar_title
    @progress_bar_path = progress_bar_path
    @multi_stage_group = multi_stage_group
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

  def multi_stage_group?
    false
  end

  private

  attr_reader :required_programme
end
