class KickOffEmailsJob < ApplicationJob
  queue_as :default

  def perform(enrolement_id)
    enrolment = UserProgrammeEnrolment.find(enrolement_id)

    case enrolment.programme.slug
    when 'secondary-certificate'
      SecondaryMailer.with(user: user).welcome.deliver_now
    when 'cs-accelerator'
      ScheduleProgrammeGettingStartedPromptJob.set(wait: 7.days).perform_later(enrolment.user.id, enrolment.programme.id)
      return CsAcceleratorMailer.with(user: enrolment.user).manual_enrolled_welcome.deliver_now unless enrolment.auto_enrolled

      CsAcceleratorMailer.with(user: enrolment.user).auto_enrolled_welcome.deliver_later(wait: delay.hours)
    end
  end

  def delay
    now = Time.now
    delay = if (9 - now.hour).negative?
              0
            else
              9 - now.hour
            end
  end
end
