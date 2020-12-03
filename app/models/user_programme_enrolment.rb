class UserProgrammeEnrolment < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :user
  belongs_to :programme

  has_many :user_programme_enrolment_transitions, autosave: false, dependent: :destroy

  after_commit :schedule_welcome_email, on: :create
  before_create :set_eligible_achievements_for_programme

  def self.initial_state
    StateMachines::UserProgrammeEnrolmentStateMachine.initial_state
  end

  def self.transition_class
    UserProgrammeEnrolmentTransition
  end

  def completed_at?
    return nil unless current_state == 'complete'

    last_transition.created_at
  end

  def set_eligible_achievements_for_programme
    user.achievements.where(programme_id: nil).each do |achievement|
      if programme.programme_activities.find_by(activity_id: achievement.activity_id)
        achievement.update(programme_id: programme.id)
      end
    end
  end

  def state_machine
    @state_machine ||= StateMachines::UserProgrammeEnrolmentStateMachine.new(self, transition_class: UserProgrammeEnrolmentTransition)
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine

  private

  def schedule_welcome_email
    case programme.slug
    when 'secondary-certificate'
      SecondaryMailer.with(user: user).welcome.deliver_now
    when 'cs-accelerator'
      ScheduleProgrammeGettingStartedPromptJob.set(wait: 7.days).perform_later(user.id, programme.id)
      CsAcceleratorMailer.with(user: user).manual_enrolled_welcome.deliver_now
    end
  end
end
