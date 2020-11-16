module FutureLearn
  class UserInformationJob < ApplicationJob
    retry_on Faraday::UnauthorizedError, attempts: 3
    queue_as :default

    def perform(membership_id:)
      organisation_membership =
        FutureLearn::Queries::OrganisationMemberships.one(membership_id)

      ext_learner_id = organisation_membership[:external_learner_id]
      user = User.find_by(id: ext_learner_id)
      user ||= User.find_by('email ILIKE ?', ext_learner_id)

      return unless user

      user.with_lock do
        unless user.future_learn_organisation_memberships.include?(membership_id)
          user.future_learn_organisation_memberships << membership_id
          user.save
        end
      end
    end
  end
end
