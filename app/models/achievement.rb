class Achievement < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :activity
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:activity_id] }

  has_many :achievement_transitions, autosave: false, dependent: :destroy

  scope :for_programme, ->(programme) {
    where('activity_id IN (SELECT activity_id FROM programme_activities WHERE programme_id = ?)', programme.id)
  }

  scope :with_category, lambda { |category|
    joins(:activity).where(activities: { category: category })
  }

  scope :without_category, lambda { |category|
    joins(:activity).where.not(activities: { category: category })
  }

  def state_machine
    @state_machine ||= StateMachines::AchievementStateMachine.new(self, transition_class: AchievementTransition)
  end

  def set_to_complete(extra_metadata = {})
    return false unless can_transition_to?(:complete)

    metadata = extra_metadata.merge(credit: activity.credit)
    transition_to(:complete, metadata)
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, to: :state_machine
end
