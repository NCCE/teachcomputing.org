class Achievement < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :activity
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:activity_id] }

  has_many :achievement_transitions, autosave: false

  def state_machine
    @state_machine ||= StateMachines::AchievementStateMachine.new(self, transition_class: AchievementTransition)
  end

  def set_to_complete
    return false unless can_transition_to?(:complete)

    transition_to(:complete, credit: activity.credit)
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, to: :state_machine
end
