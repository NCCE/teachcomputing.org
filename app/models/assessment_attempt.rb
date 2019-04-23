class AssessmentAttempt < ApplicationRecord
  has_many :transitions, class_name: 'AsessmentAttemptTransition', autosave: false

  belongs_to :user
  belongs_to :assessment

  def state_machine
    @state_machine ||= StateMachines::AssessmentAttemptStateMachine.new(self, transition_class: AsessmentAttemptTransition,
                                                                              association_name: :transitions)
  end

  def self.transition_class
    AsessmentAttemptTransition
  end

  def self.initial_state
    :commenced
  end
  private_class_method :initial_state
end
