module FutureLearn
  class CourseRunEnrolmentsJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, run_uuid:)
      enrolments = FutureLearn::Queries::CourseEnrolments.all(run_uuid)

      known_organisation_membership_uuids = User.pluck(
        :future_learn_organisation_membership_uuid
      ).compact

      enrolments.each do |enrolment|
        if known_organisation_membership_uuids.include?(
          enrolment.organisation_membership.uuid
        )
          FutureLearn::UpdateUserActivityJob.perform_later(
            course_uuid: course_uuid,
            enrolment: enrolment.to_json
          )
        else
          FutureLearn::UserInformationJob.perform_later(
            course_uuid: course_uuid,
            enrolment: enrolment.to_json
          )
        end
      end
    end
  end
end
