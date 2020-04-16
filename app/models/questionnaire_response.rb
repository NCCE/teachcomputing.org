class QuestionnaireResponse < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :questionnaire
  belongs_to :user
  belongs_to :programme

  has_many :questionnaire_response_transitions, autosave: false, dependent: :destroy

  validates :questionnaire_id, :user_id, :programme_id, presence: true
  validates :user_id, uniqueness: { scope: %i[programme_id questionnaire_id] }

  def answer_current_question(answer)
    self.answers[current_question] = answer
    self.current_question = current_question + 1
    save
  end

  def state_machine
    @state_machine ||= StateMachines::QuestionnaireResponseStateMachine.new(self, transition_class: QuestionnaireResponseTransition)
  end

  def self.transition_class
    QuestionnaireResponseTransition
  end

  def self.initial_state
    StateMachines::QuestionnaireResponseStateMachine.initial_state
  end
  private_class_method :initial_state

  delegate :can_transition_to?, :current_state,
           :transition_to, :last_transition, to: :state_machine
end
