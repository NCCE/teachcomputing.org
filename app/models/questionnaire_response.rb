class QuestionnaireResponse < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: QuestionnaireResponseTransition,
    initial_state: StateMachines::QuestionnaireResponseStateMachine.initial_state
  ]

  belongs_to :questionnaire
  belongs_to :user

  has_many :questionnaire_response_transitions, autosave: false, dependent: :destroy

  validates :user_id, uniqueness: {scope: %i[questionnaire_id]}

  def answer_current_question(step_index, answer, next_step_index)
    answers[step_index.to_s] = answer.to_s
    self.current_question = next_step_index
  end

  def state_machine
    @state_machine ||= StateMachines::QuestionnaireResponseStateMachine.new(
      self,
      transition_class: QuestionnaireResponseTransition
    )
  end

  def score
    answers.values.sum(&:to_i)
  end

  def self.transition_class
    QuestionnaireResponseTransition
  end

  def complete!
    transition_to(:complete)
  end

  def complete?
    current_state == :complete.to_s
  end

  def self.initial_state
    StateMachines::QuestionnaireResponseStateMachine.initial_state
  end
  private_class_method :initial_state

  delegate :can_transition_to?, :current_state,
    :transition_to, :last_transition, to: :state_machine
end
