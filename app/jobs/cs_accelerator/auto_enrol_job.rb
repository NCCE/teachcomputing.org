module CsAccelerator
  class AutoEnrolJob < ApplicationJob
    queue_as :default

    def perform(achievement_id:)
      achievement = Achievement.find(achievement_id)
      user = User.find(achievement.user_id)
      user.with_lock do
        return unless user.csa_auto_enrollable?
        return if user_incomplete_enrolment_on_non_csa_activity_programme(user, achievement.activity)

        user.user_programme_enrolments << UserProgrammeEnrolment.new(
          programme: Programme.cs_accelerator,
          auto_enrolled: true
        )
      end

      schedule_email(user)
    end

    private

      def user_incomplete_enrolment_on_non_csa_activity_programme(user, activity)
        non_csa_programmes = activity.programmes.where.not(id: Programme.cs_accelerator.id)
        non_csa_programmes.any? do |programme|
          programme.user_enrolled?(user) && !programme.user_completed?(user)
        end
      end

      def schedule_email(user)
        CsAcceleratorMailer.with(user: user).auto_enrolled_welcome.deliver_now
      end
  end
end
