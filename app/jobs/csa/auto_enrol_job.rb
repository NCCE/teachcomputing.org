class CSA::AutoEnrolJob < ApplicationJob
  queue_as :default

  def perform(achievement_id:)
    achievement = Achievement.find(achievement_id)
    user = User.find(achievement.user_id)
    user.with_lock do
      return unless user.csa_auto_enrollable?
      return if user_enrolled_on_non_csa_activity_programme(user, achievement.activity)

      user.user_programme_enrolments << UserProgrammeEnrolment.new(programme: Programme.cs_accelerator)
    end

    # send the email
  end

  private

    def user_enrolled_on_non_csa_activity_programme(user, activity)
      non_csa_programmes = activity.programmes.where.not(id: Programme.cs_accelerator.id)
      non_csa_programmes.any? { |programme| programme.user_enrolled?(user) }
    end
end
