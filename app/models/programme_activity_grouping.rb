class ProgrammeActivityGrouping < ApplicationRecord
  has_many :programme_activities
  belongs_to :programme

  def user_complete?(user)
    completed_activity_count = 0
    programme_activities.each do |programme_activity|
      completed_activity = user.achievements.in_state(:complete).for_programme(programme).where(activity_id: programme_activity.activity.id).any?
      completed_activity_count += 1 if completed_activity
      return true if completed_activity_count >= required_for_completion
    end
    nil
  end
end
