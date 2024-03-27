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

  after_save :queue_auto_enrolment

  has_many :achievement_transitions, autosave: false, dependent: :destroy

  scope :with_attachments, -> { joins(:activity).where(activities: {uploadable: true}) }

  scope :with_category, lambda { |category|
    joins(:activity).where(activities: {category:})
  }

  scope :with_provider, lambda { |provider|
    joins(:activity).where(activities: {provider:})
  }

  scope :with_courses, lambda {
                         joins(:activity).where(activities: {category: [Activity::FACE_TO_FACE_CATEGORY, Activity::ONLINE_CATEGORY]})
                       }

  scope :with_credit, lambda { |credit|
    joins(:activity).where(activities: {credit:})
  }

  scope :without_category, lambda { |category|
    joins(:activity).where.not(activities: {category:})
  }

  scope :sort_complete_first, lambda {
    select("achievements.*, COALESCE(most_recent_achievement_transition.to_state, 'enrolled') as current_state")
      .joins(most_recent_transition_join)
      .order("current_state")
  }

  scope :belonging_to_programme, ->(programme) { joins(activity: {programme_activities: :programme}).where(activities: {programme_activities: {programme:}}) }
  scope :belonging_to_pathway, ->(pathway) { joins(activity: {pathway_activities: :pathway}).where(activities: {pathway_activities: {pathway:}}) }

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

  def update_progress_and_state(progress = 0, left_at = nil)
    update_progress(progress.floor)

    return drop!(left_at:) if left_at.present? && (progress < 60)

    update_state_from_progress(progress.floor) unless complete?
  end

  def complete?
    in_state?(:complete)
  end

  def dropped?
    in_state?(:dropped)
  end

  def drafted?
    in_state?(:drafted)
  end

  def self_verification_info
    super.presence || state_machine.last_transition&.metadata&.dig("self_verification_info")
  end

  def adequate_evidence_provided?
    activity.self_verification_info.nil? ||
      self_verification_info.present? ||
      supporting_evidence.present?
  end

  def transition_community_to_complete
    metadata = {credit: activity.credit}

    if self_verification_info.present? || supporting_evidence.present?
      metadata[:self_verification_info] = "#{self_verification_info} #{url_for(supporting_evidence) if supporting_evidence.present?}"
    end

    transition_to(:complete, metadata)
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine
  delegate :provider, :title, :stem_activity_code, :slug, :active_course?, to: :activity

  def belonging_to_programme?(programme)
    return false unless programme

    activity.programme_activities.exists?(programme:)
  end

  private

  def queue_auto_enrolment
    AutoEnrolJob.perform_later(achievement: self)
  end

  def update_state_from_progress(updated_progress)
    case updated_progress
    when 0
      transition_to(:enrolled) if can_transition_to?(:enrolled)
    when 1..59
      transition_to(:in_progress) if can_transition_to?(:in_progress)
    when 60..100
      complete!
    end
  end

  def update_progress(updated_progress)
    return if updated_progress < progress

    update(progress: updated_progress)
  end
end
