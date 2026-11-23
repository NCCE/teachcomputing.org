class Achievement < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: AchievementTransition,
    initial_state: StateMachines::AchievementStateMachine.initial_state
  ]
  include ActionView::Helpers::UrlHelper

  belongs_to :activity
  belongs_to :user

  has_one_attached :supporting_evidence

  validates :supporting_evidence, blob: {content_type: :image}
  validates :user_id, uniqueness: {scope: [:activity_id]}

  after_commit :queue_auto_enrolment

  has_many :achievement_transitions, autosave: false, dependent: :destroy

  scope :with_attachments, -> { joins(:activity).where(activities: {uploadable: true}) }

  scope :with_category, lambda { |category|
    joins(:activity).where(activities: {category:})
  }

  scope :with_courses, lambda {
                         joins(:activity).where(activities: {category: [Activity::FACE_TO_FACE_CATEGORY, Activity::ONLINE_CATEGORY]})
                       }

  scope :without_category, lambda { |category|
    joins(:activity).where.not(activities: {category:})
  }

  scope :with_most_recent_transition, -> {
    joins(most_recent_transition_join)
  }

  scope :sort_complete_first, lambda {
    select("achievements.*, COALESCE(most_recent_achievement_transition.to_state, 'enrolled') as current_state")
      .joins(most_recent_transition_join)
      .order("current_state")
  }

  scope :belonging_to_programme, ->(programme) { joins(activity: {programme_activities: :programme}).where(activities: {programme_activities: {programme:}}) }
  scope :belonging_to_programme_activity_grouping, ->(programme_activity_grouping) { joins(activity: {programme_activities: :programme_activity_grouping}).where(activities: {programme_activities: {programme_activity_grouping:}}) }

  def state_machine
    @state_machine ||= StateMachines::AchievementStateMachine.new(self, transition_class: AchievementTransition)
  end

  def complete!(extra_metadata = {})
    return false unless can_transition_to?(:complete)

    metadata = extra_metadata.merge(credit: activity.credit)
    transition_to(:complete, metadata)
  end

  def drop!(metadata = {})
    return false unless can_transition_to?(:dropped)

    transition_to(:dropped, metadata)
  end

  def complete?
    in_state?(:complete)
  end

  def rejected?
    in_state?(:rejected)
  end

  def adequate_evidence_provided?
    activity.public_copy_evidence.blank? ||
      evidence.present? ||
      supporting_evidence.present?
  end

  def transition_community_to_complete
    metadata = {credit: activity.credit}

    metadata[:evidence] = evidence.presence
    metadata[:supporting_evidence_url] = supporting_evidence.presence

    transition_to(:complete, metadata)
  end

  def community_achievement_complete?
    return false if activity.public_copy_submission_options

    in_state?(:complete)
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  private_class_method :initial_state, :transition_class

  delegate :allowed_transitions, :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine
  delegate :provider, :title, :stem_activity_code, :slug, :active_course?, to: :activity

  private

  def queue_auto_enrolment
    AutoEnrolJob.perform_later(achievement: self)
  end
end
