class AchievementTransition < ApplicationRecord
  validates :to_state, inclusion: {in: StateMachines::AchievementStateMachine.states}

  belongs_to :achievement, inverse_of: :achievement_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = achievement.achievement_transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update(most_recent: true)
  end
end
