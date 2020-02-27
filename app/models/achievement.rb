class Achievement < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :activity
  belongs_to :user
  belongs_to :programme, optional: true

  validates :user_id, uniqueness: { scope: [:activity_id] }

  before_create :fill_in_programme_id

  has_many :achievement_transitions, autosave: false, dependent: :destroy

  scope :for_programme, ->(programme) {
    where('activity_id IN (SELECT activity_id FROM programme_activities WHERE programme_id = ?)', programme.id)
  }

  scope :with_category, lambda { |category|
    joins(:activity).where(activities: { category: category })
  }

  scope :with_credit, lambda { |credit|
    joins(:activity).where(activities: { credit: credit })
  }

  scope :without_category, lambda { |category|
    joins(:activity).where.not(activities: { category: category })
  }

  scope :sort_complete_first, -> {
    select("achievements.*, COALESCE(most_recent_achievement_transition.to_state, 'enrolled') as current_state")
    .joins(most_recent_transition_join)
    .order('current_state')
  }

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

    metadata = { progress: progress }

    return set_to_dropped(left_at: left_at) if left_at.present?

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
    current_state == 'complete'
  end

  def self.initial_state
    StateMachines::AchievementStateMachine.initial_state
  end

  def self.transition_class
    AchievementTransition
  end

  private_class_method :initial_state, :transition_class

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, to: :state_machine

  private

    def fill_in_programme_id
      return if programme_id

      programmes = activity.programmes

      return if programmes.size.zero?

      find_matching_programme(programmes)
    end

    def find_matching_programme(programmes)
      if programmes.size == 1
        self.programme_id = programmes.first.id
      else
        programme_ids = programmes.pluck(:id)
        user_programme_ids = user.user_programme_enrolments
                                 .in_state('enrolled')
                                 .order(created_at: :desc)
                                 .pluck(:programme_id)

        user_programme_ids.each do |user_programme_id|
          if programme_ids.include?(user_programme_id)
            self.programme_id = user_programme_id
            break
          end
        end
      end
    end
end
