module DashboardHelper
  def has_user_completed_activity?(user, activity)
    return false if user.blank? || activity.blank?
    user.achievements.any? { |a| a.activity.id == activity.id }
  end
end
