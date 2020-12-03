class KickOffEmailsJob < ApplicationJob
  queue_as :default

  def perform(user_id, programme_id)
    user = User.find(user_id)
    programme = Programme.find(programme_id)

    case programme.slug
    when 'secondary-certificate'
      SecondaryMailer.with(user: user).welcome.deliver_now
    when 'cs-accelerator'
      ScheduleProgrammeGettingStartedPromptJob.set(wait: 7.days).perform_later(user.id, programme.id)
      CsAcceleratorMailer.with(user: user).manual_enrolled_welcome.deliver_now
    end
  end
end
