class Achievement < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :activity
  belongs_to :user
  belongs_to :programme, optional: true

  has_one_attached :supporting_evidence

  validates :supporting_evidence, blob: { content_type: :image }
  validates :user_id, uniqueness: { scope: [:activity_id] }

  before_create :fill_in_programme_id,
                unless: proc { |achievement| achievement.programme_id }

  after_save :queue_auto_enrolment

  has_many :achievement_transitions, autosave: false, dependent: :destroy

  scope :for_programme, lambda { |programme|
    where(programme_id: programme.id)
  }

  scope :with_attachments, -> { joins(:activity).where(activities: { uploadable: true }) }

  scope :with_category, lambda { |category|
    joins(:activity).where(activities: { category: category })
  }

  scope :with_provider, lambda { |provider|
    joins(:activity).where(activities: { provider: provider })
  }

  scope :with_courses, lambda {
                         joins(:activity).where(activities: { category: [Activity::FACE_TO_FACE_CATEGORY, Activity::ONLINE_CATEGORY] })
                       }

  scope :with_credit, lambda { |credit|
    joins(:activity).where(activities: { credit: credit })
  }

  scope :without_category, lambda { |category|
    joins(:activity).where.not(activities: { category: category })
  }

  scope :sort_complete_first, lambda {
    select("achievements.*, COALESCE(most_recent_achievement_transition.to_state, 'enrolled') as current_state")
      .joins(most_recent_transition_join)
      .order('current_state')
  }

  def eligible_for_badge?
    return unless programme
    return unless programme.credly_badge_template_id.present?
    return unless user.user_programme_enrolments.find_by(programme_id: programme.id)

    first_stem_achievement = user.achievements.in_state(:complete).with_provider('stem-learning').for_programme(programme).count == 1

    Credly::IssueBadgeJob.perform_later(user.id, programme.id) if first_stem_achievement
  end

  def state_machine
    @state_machine ||= StateMachines::AchievementStateMachine.new(self, transition_class: AchievementTransition)
  end

  def set_to_complete(extra_metadata = {})
    return false unless can_transition_to?(:complete)

    metadata = extra_metadata.merge(credit: activity.credit)
    transition_to(:complete, metadata)
  end

  def set_to_dropped(metadata = {})
    return false unless can_transition_to?(:dropped)

    transition_to(:dropped, metadata)
  end

  def update_state_for_online_activity(progress = 0, left_at = nil)
    return if current_state == :complete.to_s

    metadata = { progress: progress.floor }

    return set_to_dropped(left_at: left_at) if left_at.present? && !(progress >= 60)

    case progress
    when 0
      transition_to(:enrolled) if can_transition_to?(:enrolled)
    when 1..59
      transition_to(:in_progress, metadata) if can_transition_to?(:in_progress)
      state_machine.last_transition.update(metadata: metadata)
    when 60..100
      set_to_complete(metadata)
    end
  end

  def complete?
    in_state?(:complete)
  end

  def dropped?
    in_state?(:dropped)
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  def primary_certificate?
    programme.present? && programme.primary_certificate?
  end

  def secondary_certificate?
    programme.present? && programme.secondary_certificate?
  end

  def cs_accelerator?
    programme.present? && programme.cs_accelerator?
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, :in_state?, to: :state_machine
  delegate :title, :stem_activity_code, :slug, to: :activity

  private

    def fill_in_programme_id
      programmes = activity.programmes

      return if programmes.empty?

      self.programme_id = find_matching_programme_id(programmes)
    end

    def find_matching_programme_id(programmes)
      return programmes.first.id if programmes.size == 1

      user_programme_ids = user.user_programme_enrolments
                               .where(programme_id: programmes.pluck(:id))
                               .not_in_state(:unenrolled)
                               .order(created_at: :desc)
                               .pluck(:programme_id)
      user_programme_ids.first
    end

    def queue_auto_enrolment
      return unless activity.programmes.any?(&:cs_accelerator?)
      return unless user.csa_auto_enrollable?

      CSAccelerator::AutoEnrolJob.perform_later(achievement_id: id)
    end
end
