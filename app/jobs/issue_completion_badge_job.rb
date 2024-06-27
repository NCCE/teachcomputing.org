class IssueCompletionBadgeJob < ApplicationJob
  queue_as :default

  def perform(user_programme_enrolment)
    return unless user_programme_enrolment.in_state?(:complete)
    user = user_programme_enrolment.user
    programme = user_programme_enrolment.programme

    badge = programme.completion_badge

    return unless badge
    return if Credly::Badge.user_has_programme_completion_badge?(user, programme)

    Credly::Badge.issue(user.id, badge.credly_badge_template_id)
    # NewBadgeMailer.new_badge_email(user, programme).deliver_now
  end
end
