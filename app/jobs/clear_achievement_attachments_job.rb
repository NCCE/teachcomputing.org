class ClearAchievementAttachmentsJob < ApplicationJob
  queue_as :default

  def perform(enrolment)
    return unless enrolment.in_state?(:complete)

    achievements_with_attachments = enrolment.user.achievements.with_attachments.belongs_to_programme(enrolment.programme)
    achievements_with_attachments.each do |achievement|
      achievement.supporting_evidence.purge
    end
  end
end
