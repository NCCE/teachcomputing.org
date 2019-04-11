class Achievement < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:activity_id]

  has_many :achievement_transitions, autosave: false

  def state_machine
    @state_machine ||= StateMachines::AchievementStateMachine.new(self, transition_class: AchievementTransition)
  end

  def self.transition_class
    AchievementTransition
  end
  private_class_method :transition_class

  def self.initial_state
    :enrolled
  end
  private_class_method :initial_state
end
