module FutureLearn
  class UserInformationJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, enrolment:)
      org_membership_id = enrolment[:organisation_membership][:uuid]
      organisation_membership =
        FutureLearn::Queries::OrganisationMemberships.one(org_membership_id)

      ext_learner_id = organisation_membership[:external_learner_id]
      user = User.find_by(id: ext_learner_id)
      user ||= User.find_by('email ILIKE ?', ext_learner_id)

      return unless user

      user.with_lock do
        unless user.future_learn_organisation_memberships.include?(org_membership_id)
          user.future_learn_organisation_memberships << org_membership_id
          user.save
        end
      end

      FutureLearn::UpdateUserActivityJob.perform_later(
        course_uuid: course_uuid,
        enrolment: enrolment
      )
    end
  end
end
