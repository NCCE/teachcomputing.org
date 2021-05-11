class UserProgrammeEnrolment < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :user
  belongs_to :programme
  belongs_to :pathway, optional: true

  has_many :user_programme_enrolment_transitions, autosave: false, dependent: :destroy

  after_commit :schedule_kick_off_emails, :schedule_sync_to_achiever, :create_questionnaire_response, on: :create
  before_create :set_eligible_achievements_for_programme

  validates :user, :programme, presence: true
  validates :user, uniqueness: { scope: [:programme] }

  def self.initial_state
    StateMachines::UserProgrammeEnrolmentStateMachine.initial_state
  end

  def self.transition_class
    UserProgrammeEnrolmentTransition
  end

  def completed_at?
    return nil unless in_state?(:complete)

    last_transition.created_at
  end

  def set_eligible_achievements_for_programme
    user.achievements.where(programme_id: nil).each do |achievement|
      if programme.programme_activities.find_by(activity_id: achievement.activity_id)
        achievement.update(programme_id: programme.id)
      end
    end
  end

  def assign_recommended_pathway(questionnaire_response)
    recommender = Programmes::CSAccelerator::PathwayRecommender.new(questionnaire_response: questionnaire_response)
    update(pathway_id: recommender.recommended_pathway&.id)
  end

  def state_machine
    @state_machine ||= begin
      StateMachines::UserProgrammeEnrolmentStateMachine.new(
        self, transition_class: UserProgrammeEnrolmentTransition
      )
    end
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine

  private

    def create_questionnaire_response
      return unless programme.cs_accelerator?

      QuestionnaireResponse.create(user: user, questionnaire: Questionnaire.cs_accelerator)
    end

    def schedule_kick_off_emails
      KickOffEmailsJob.perform_later(id)
    end

    def schedule_sync_to_achiever
      Achiever::ScheduleCertificateSyncJob.perform_later(id)
    end
end
