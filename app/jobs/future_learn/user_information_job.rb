module FutureLearn
  class UserInformationJob < ApplicationJob
    queue_as :default

    def perform(membership_id:)
      retries ||= 0
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
    rescue Faraday::UnauthorizedError => e
      retry if (retries += 1) < 3
      Raven.capture_message("Error retrieving organisation membership: #{e}, Membership UUID: #{membership_id}")
    end
  end
end
