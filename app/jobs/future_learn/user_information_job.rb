module FutureLearn
  class UserInformationJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, enrolment:)
      organisation_membership =
        FutureLearn::Queries::OrganisationMemberships.one(enrolment[:organisation_membership][:uuid])

      user = User.find_by(id: organisation_membership[:external_learner_id])
      user ||= User.find_by('email ILIKE ?', organisation_membership[:external_learner_id])

      return unless user

      user.future_learn_organisation_memberships << organisation_membership[:uuid]
      user.save

      FutureLearn::UpdateUserActivityJob.perform_later(
        course_uuid: course_uuid,
        enrolment: enrolment
      )
    end
  end
end
