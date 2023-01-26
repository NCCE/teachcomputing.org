class ProgrammeActivityGrouping < ApplicationRecord
  has_many :programme_activities, -> { order(:order) }
  belongs_to :programme

  def achievements(user)
    @achievements ||= user.achievements.in_state(:complete).for_programme(programme).includes(:activity)
  end

  def user_complete?(user)
    completed_activity_count = 0
    user_achievements = achievements(user)
    programme_activities.each do |programme_activity|
      completed_activity = user_achievements.find_by(activity_id: programme_activity.activity.id)
      completed_activity_count += 1 if completed_activity
      return true if completed_activity_count >= required_for_completion
    end
    nil
  end
end
