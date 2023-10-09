class IssueBadgeJob < ApplicationJob
  queue_as :default

  def perform(achievement)
    user = achievement.user

    achievement.activity.programmes.each do |programme|
      badge = programme.badges.active.first

      next if !badge ||
        !programme.badgeable? ||
        !programme.user_enrolled?(user) ||
        user_has_badge?(user, programme) ||
        !has_face_to_face_achievements?(user, programme)


      Credly::Badge.issue(user.id, badge.credly_badge_template_id)
      NewBadgeMailer.new_badge_email(user, programme).deliver_now
    end
  end

  private

  def user_has_badge?(user, programme)
    Credly::Badge.by_programme_badge_template_ids(user.id, programme.badges.pluck(:credly_badge_template_id))
  end

  def has_face_to_face_achievements?(user, programme)
    user
      .achievements
      .in_state(:complete)
      .with_category(Activity::FACE_TO_FACE_CATEGORY)
      .belonging_to_programme(programme)
      .count >0 0
  end
end
