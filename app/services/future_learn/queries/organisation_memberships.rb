module FutureLearn
  module Queries
    class OrganisationMemberships
      ENDPOINT = '/partners/organisation_memberships'.freeze

      def self.one(membership_uuid)
        FutureLearn::Request.run(ENDPOINT, membership_uuid)
      end
    end
  end
end
