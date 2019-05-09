module ProgrammesHelper
  def can_take_accelerator_test?(user)
    programme = Programme.find_by!(slug: 'cs-accelerator')
    return false if user.blank? || !programme.user_enrolled?(user)

    activities = user.achievements.for_programme(programme).in_state('complete').joins(:activity)
    online_total = activities.where(activities: { category: 'online'}).sum(:credit)
    face_to_face_total = activities.where(activities: { category: 'face-to-face'}).sum(:credit)

    online_total >= 40 && face_to_face_total >= 40
  end

  def achievements_completed_by_the_user?(user)
    programme = Programme.find_by!(slug: 'cs-accelerator')
    activities = user.achievements.for_programme(programme).joins(:activity).first.activity.title

    return activities
  end

end
