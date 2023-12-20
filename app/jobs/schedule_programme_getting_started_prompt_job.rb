class ScheduleProgrammeGettingStartedPromptJob < ApplicationJob
  queue_as :default

  def perform(enrolment_id)
    enrolment = UserProgrammeEnrolment.find(enrolment_id)

    return if enrolment.user.achievements.belonging_to_programme(enrolment.programme).count.positive?

    case enrolment.programme.slug
    when 'subject-knowledge'
      CSAcceleratorMailer.with(user: enrolment.user, enrolment_id: enrolment.id).getting_started_prompt.deliver_now
    when 'primary-certificate'
      PrimaryMailer.with(user: enrolment.user, enrolment_id: enrolment.id).inactive_prompt.deliver_now
    when 'secondary-certificate'
      SecondaryMailer.with(user: enrolment.user, enrolment_id: enrolment.id).inactive_prompt.deliver_now
    end
  end
end
