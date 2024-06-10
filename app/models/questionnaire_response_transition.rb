class QuestionnaireResponseTransition < ApplicationRecord
  belongs_to :questionnaire_response, inverse_of: :questionnaire_response_transitions

  validates :to_state, inclusion: {in: StateMachines::QuestionnaireResponseStateMachine.states}

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = questionnaire_response.questionnaire_response_transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update(most_recent: true)
  end
end
