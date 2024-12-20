class UserProgrammeEnrolment < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: UserProgrammeEnrolmentTransition,
    initial_state: StateMachines::UserProgrammeEnrolmentStateMachine.initial_state
  ]

  belongs_to :user
  belongs_to :programme
  belongs_to :pathway, optional: true

  has_many :user_programme_enrolment_transitions, autosave: false, dependent: :destroy
  has_many :achiever_sync_records, dependent: :destroy

  validates :user, uniqueness: {scope: [:programme]}
  validates :pathway, presence: true, if: -> { programme&.pathways? }

  store_accessor :message_flags, %i[primary_pathway_migrated], prefix: true
  store_accessor :complete_certificate_metadata, %i[certificate_name]

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

  def last_enrolled_at
    return last_transition.created_at if state_machine.history.any?

    created_at
  end

  def assign_pathway(pathway_slug)
    pathway = Pathway.find_by(programme_id: programme.id, slug: pathway_slug)
    update(pathway_id: pathway.id)
  end

  def assign_recommended_pathway(questionnaire_response)
    recommender = Programmes::CSAccelerator::PathwayRecommender.new(questionnaire_response:)
    update(pathway_id: recommender.recommended_pathway&.id)
  end

  def state_machine
    @state_machine ||= StateMachines::UserProgrammeEnrolmentStateMachine.new(
      self, transition_class: UserProgrammeEnrolmentTransition
    )
  end

  private_class_method :initial_state, :transition_class

  delegate :allowed_transitions, :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine
end
