class UserProgrammeEnrolmentTransition < ApplicationRecord
  validates :to_state, inclusion: {in: StateMachines::UserProgrammeEnrolmentStateMachine.states}

  belongs_to :user_programme_enrolment, inverse_of: :user_programme_enrolment_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = user_programme_enrolment.user_programme_enrolment_transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.update_column(:most_recent, true)
  end
end
