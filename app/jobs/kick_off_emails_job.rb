class KickOffEmailsJob < ApplicationJob
  queue_as :default

  def perform(enrolment_id)
    enrolment = UserProgrammeEnrolment.find(enrolment_id)
    programme = enrolment.programme

    if programme.auto_enrollable? && enrolment.auto_enrolled
      programme.mailer.with(user: enrolment.user).auto_enrolled.deliver_later(wait: delay.hours)
    else
      programme.mailer.with(user: enrolment.user).enrolled.deliver_now
    end

    ScheduleProgrammeGettingStartedPromptJob.set(wait: 1.month).perform_later(enrolment_id)
  end

  def delay
    now = DateTme.now
    if (9 - now.hour).negative?
      0
    else
      9 - now.hour
    end
  end
end
