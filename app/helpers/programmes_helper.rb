module ProgrammesHelper
  def can_take_accelerator_test?(user, programme)
    credits_for_accelerator(user, programme) >= 80
  end

  def credits_for_accelerator(user, programme)
    online_total = [_credits_for_courses(user, programme, 'online'), 40].min
    face_to_face_total = [_credits_for_courses(user, programme, 'face-to-face'), 40].min
    online_total + face_to_face_total
  end

  private
    def _credits_for_courses(user, programme, category = 'online')
      activities = user.achievements.for_programme(programme).in_state('complete').joins(:activity)
      activities.where(activities: { category: category}).sum(:credit)
    end
end
