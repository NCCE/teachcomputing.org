module CSAccelerator
  class CheckNextStepsJob < ApplicationJob
    queue_as :default

    def perform(achievement_id)
      programme = Programme.cs_accelerator
      achievement = Achievement.find(achievement_id)
      user = achievement.user
      enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

      return unless enrolment
      return if programme.enough_credits_for_test?(user)
      return if enrolment.current_state == "complete"

      AchievementMailer.with(user_id: user.id).completed_course.deliver_now
    end
  end
end
