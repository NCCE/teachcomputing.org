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

    ScheduleIBelongStudentSurveyPromptJob.set(wait: 1.week).perform_later(enrolment.user) if programme.i_belong?
  end

  def delay
    now = DateTime.now
    if (9 - now.hour).negative?
      0
    else
      9 - now.hour
    end
  end
end
