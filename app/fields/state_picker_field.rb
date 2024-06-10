require "administrate/field/base"

class StatePickerField < Administrate::Field::Base
  def valid_states_for_change
    resource.allowed_transitions
  end

  def name
    "Current State"
  end

  def to_s
    data.to_s
  end

  def objectives
    @objectives ||= resource.programme.programme_objectives
  end

  def objective_color(objective)
    return "red" if user.blank? || objective.blank?

    objective.user_complete?(user) ? "green" : "red"
  end

  def objective_title(objective)
    return "" unless objective.present? && objective.progress_bar_title.present?

    objective.progress_bar_title.upcase_first
  end

  private

  def user
    @user ||= resource.user
  end
end
