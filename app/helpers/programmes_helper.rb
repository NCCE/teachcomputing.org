module ProgrammesHelper
  def can_take_accelerator_test?(user)
    programme = Programme.find_by(slug: 'cs-accelerator')
    return false if user.blank? || programme.blank?

    return false if !programme.user_enrolled?(user)

    activities = user.achievements.for_programme(programme).in_state('complete').joins(:activity)
    online_total = activities.where(activities: { category: 'online'}).sum(:credit)
    face_to_face_total = activities.where(activities: { category: 'face-to-face'}).sum(:credit)
    diagnostic = activities.where(activities: { slug: 'downloaded-diagnostic-tool'}).exists?

    diagnostic && online_total >= 40 && face_to_face_total >= 40
  end
end
