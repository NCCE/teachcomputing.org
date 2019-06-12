class AssessmentAttempt < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries
  belongs_to :user
  belongs_to :assessment

  has_many :assessment_attempt_transitions, autosave: false, dependent: :destroy

  scope :passed_attempts_with_user, -> {
    in_state(:passed).includes(:user).order('most_recent_assessment_attempt_transition.created_at ASC')
  }

  def state_machine
    @state_machine ||= StateMachines::AssessmentAttemptStateMachine.new(self, transition_class: AssessmentAttemptTransition)
  end

  def self.transition_class
    AssessmentAttemptTransition
  end

  def self.initial_state
    StateMachines::AssessmentAttemptStateMachine.initial_state
  end
  private_class_method :initial_state

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, to: :state_machine
end
