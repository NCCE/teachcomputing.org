class KickOffEmailsJob < ApplicationJob
  queue_as :default

  def perform(enrolment_id)
    enrolment = UserProgrammeEnrolment.find(enrolment_id)

    case enrolment.programme.slug
    when 'secondary-certificate'
      SecondaryMailer.with(user: enrolment.user).welcome.deliver_now
    when 'cs-accelerator'
      ScheduleProgrammeGettingStartedPromptJob.set(wait: 7.days).perform_later(enrolment.user.id, enrolment.programme.id)
      if enrolment.auto_enrolled?
        CsAcceleratorMailer.with(user: enrolment.user).auto_enrolled_welcome.deliver_later(wait: delay.hours)
      else
        CsAcceleratorMailer.with(user: enrolment.user).manual_enrolled_welcome.deliver_now
      end
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
