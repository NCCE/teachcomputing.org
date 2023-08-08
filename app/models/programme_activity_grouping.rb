class ProgrammeActivityGrouping < ApplicationRecord
  has_many :programme_activities, -> { order(:order) }
  belongs_to :programme

  scope :progress_bar_grouping, -> { where.not(progress_bar_title: nil) }
  
  def achievements(user)
    user.achievements.in_state(:complete).for_programme(programme)
  end

  def user_complete?(user)
    completed_activity_count = 0
    user_achievements = achievements(user).to_a
    programme_activities.each do |programme_activity|
      completed_activity = user_achievements.find { _1.activity_id == programme_activity.activity_id }
      completed_activity_count += 1 if completed_activity
      return true if completed_activity_count >= required_for_completion
    end
    nil
  end
end
