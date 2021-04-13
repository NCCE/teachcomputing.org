module Credly
  class Badge
    ORG_ID = ENV['CREDLY_ORGANISATION_ID'].freeze
    BADGES_RESOURCE_PATH = "organizations/#{ORG_ID}/badges".freeze
    TEMPLATES_RESOURCE_PATH = "organizations/#{ORG_ID}/badge_templates".freeze

    def self.all
      Credly::Request.run(TEMPLATES_RESOURCE_PATH, nil)[:data]
    end

    def self.issue(user_id, badge_template_id)
      user = User.find(user_id)
      body = {
        'recipient_email' => user.email,
        'badge_template_id' => badge_template_id,
        'issuer_earner_id' => user.id,
        'suppress_badge_notification_email' => false
      }.to_json
      Credly::Request.run(TEMPLATES_RESOURCE_PATH, body)
    end

    def self.issued(user_id = nil)
      user = User.find(user_id)
      query_strings = "?filter=recipient_email::#{user.email}" if user
      Credly::Request.run(BADGES_RESOURCE_PATH + query_strings, {})[:data]
    end
  end
end
