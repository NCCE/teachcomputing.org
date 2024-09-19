class IssueCpdBadgeJob < ApplicationJob
  queue_as :default

  def perform(achievement: nil)
    user = achievement.user
    programmes = achievement.activity.programmes

    programmes.each do |programme|
      badge = programme.cpd_badge

      next unless badge
      next unless programme.user_qualifies_for_credly_cpd_badge?(user)
      next if Credly::Badge.user_has_programme_cpd_badge?(user, programme)

      begin
        Credly::Badge.issue(user.id, badge.credly_badge_template_id)
        NewBadgeMailer.new_badge_email(user, programme).deliver_now
      rescue Credly::Error => e
        Sentry.capture_exception(e)
      end
    end
  end
end
