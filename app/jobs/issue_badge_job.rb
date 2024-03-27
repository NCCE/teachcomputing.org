class IssueBadgeJob < ApplicationJob
  queue_as :default

  def perform(achievement: nil, assessment_attempt: nil)
    if achievement
      user = achievement.user
      programmes = achievement.activity.programmes
    elsif assessment_attempt
      user = assessment_attempt.user
      programmes = [assessment_attempt.assessment.programme]
    end

    programmes.each do |programme|
      badge = programme.badges.active.first

      next unless badge
      next unless programme.badgeable?
      next unless programme.user_qualifies_for_credly_badge?(user)
      next if user_has_badge?(user, programme)

      Credly::Badge.issue(user.id, badge.credly_badge_template_id)
      NewBadgeMailer.new_badge_email(user, programme).deliver_now
    end
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.pluck(:credly_badge_template_id))
  end
end
