class KickOffEmailsJob < ApplicationJob
  queue_as :default

  def perform(enrolment_id)
    enrolment = UserProgrammeEnrolment.find(enrolment_id)

    case enrolment.programme.slug
    when 'primary-certificate'
      PrimaryMailer.with(user: enrolment.user).enrolled.deliver_now
    when 'i-belong', 'secondary-certificate'
      enrolment.programme.mailer.with(user: enrolment.user).welcome.deliver_now
    when 'cs-accelerator'
      CSAcceleratorMailer.with(user: enrolment.user).manual_enrolled_welcome.deliver_now unless enrolment.auto_enrolled
      CSAcceleratorMailer.with(user: enrolment.user).auto_enrolled_welcome.deliver_later(wait: delay.hours)
    end
    ScheduleProgrammeGettingStartedPromptJob.set(wait: 1.month).perform_later(enrolment_id)
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
