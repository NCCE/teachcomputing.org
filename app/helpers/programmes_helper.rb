module ProgrammesHelper
  def can_take_accelerator_test?(user, programme)
    credits_for_accelerator(user, programme) { |total| return total >= 80 }
  end

  def credits_for_accelerator(user, programme)
    online_total = [_credits_for_courses(user, programme, 'online'), 40].min
    face_to_face_total = [_credits_for_courses(user, programme, 'face-to-face'), 40].min
    yield online_total + face_to_face_total
  end
  
  def achievements_completed_by_the_user?(user)
    programme = Programme.find_by!(slug: 'cs-accelerator')
    activities = user.achievements.for_programme(programme).joins(:activity).first.activity.title

    return activities
  end

  private
    def _credits_for_courses(user, programme, category = 'online')
      activities = user.achievements.for_programme(programme).in_state('complete').joins(:activity)
      activities.where(activities: { category: category}).sum(:credit)
    end
end
