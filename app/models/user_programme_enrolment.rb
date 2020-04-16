class UserProgrammeEnrolment < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :user
  belongs_to :programme

  has_many :user_programme_enrolment_transitions, autosave: false, dependent: :destroy

  after_commit :schedule_get_started_prompt, on: :create

  def self.initial_state
    StateMachines::UserProgrammeEnrolmentStateMachine.initial_state
  end

  def self.transition_class
    UserProgrammeEnrolmentTransition
  end

  def state_machine
    @state_machine ||= StateMachines::UserProgrammeEnrolmentStateMachine.new(self, transition_class: UserProgrammeEnrolmentTransition)
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, to: :state_machine

  private
    def schedule_get_started_prompt
      ScheduleProgrammeGettingStartedPromptJob.set(wait: 7.days).perform_later(user.id, programme.id)
    end
end
