module Credly
  class Badges
    ORG_ID = ENV['CREDLY_ORGANISATION_ID'].freeze
    RESOURCE_PATH = "organizations/#{ORG_ID}/badge_templates".freeze

    def self.all
      Credly::Request.run(RESOURCE_PATH, nil)
    end
  end
end
