module Credly
  class Badge
    ORG_ID = ENV['CREDLY_ORGANISATION_ID'].freeze
    BADGES_RESOURCE_PATH = "organizations/#{ORG_ID}/badges".freeze
    TEMPLATES_RESOURCE_PATH = "organizations/#{ORG_ID}/badge_templates".freeze

    def self.templates
      Credly::Request.run(TEMPLATES_RESOURCE_PATH, {})[:data]
    end

    def self.issue(user_id, template_id)
      user = User.find(user_id)
      body = {
        'recipient_email' => user.email,
        'issued_to_first_name' => user.first_name,
        'issued_to_last_name' => user.last_name,
        'badge_template_id' => template_id,
        'issued_at' => DateTime.now.strftime('%Y-%m-%d %H:%M:%S %z'),
        'issuer_earner_id' => user.id
      }.to_json
      Credly::Request.run(BADGES_RESOURCE_PATH, body)[:data]
    end

    def self.issued(user_id)
      user = User.find(user_id)
      query_strings = "?filter=recipient_email::#{user.email}"
      Credly::Request.run(BADGES_RESOURCE_PATH + query_strings, {})[:data]
    end

    def self.by_badge_template_id(user_id, badge_template_id)
      badge_template_id = '00cd7d3b-baca-442b-bce5-f20666ed591b'
      issued = Credly::Badge.issued(user_id)

      badges = issued.keep_if { |issued| issued[:badge_template][:id] == badge_template_id }
      return unless badges.any?

      badges.last
    end
  end
