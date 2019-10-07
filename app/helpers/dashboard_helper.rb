module DashboardHelper
  def has_user_completed_activity?(user, activity)
    user.achievements.any? { |a| a.activity.id == activity.id }
  end
end
