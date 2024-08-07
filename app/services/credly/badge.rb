module Credly
  class Badge
    ORG_ID = Rails.application.config.credly_org_id.freeze
    BADGES_RESOURCE_PATH = "organizations/#{ORG_ID}/badges".freeze
    TEMPLATES_RESOURCE_PATH = "organizations/#{ORG_ID}/badge_templates".freeze

    def self.templates
      Credly::Request.run(TEMPLATES_RESOURCE_PATH, {})[:data]
    end

    def self.issue(user_id, template_id)
      user = User.find(user_id)

      body = {
        "recipient_email" => user.email,
        "issued_to_first_name" => user.first_name,
        "issued_to_last_name" => user.last_name,
        "badge_template_id" => template_id,
        "issued_at" => DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z"),
        "issuer_earner_id" => user.id
      }.to_json
      Credly::Request.run(BADGES_RESOURCE_PATH, body)[:data]
    end

    def self.issued(user_id)
      user = User.find(user_id)
      query_strings = "?filter=issuer_earner_id::#{user.id}"
      Credly::Request.run(BADGES_RESOURCE_PATH + query_strings, {})[:data]
    end

    def self.user_has_programme_completion_badge?(user, programme)
      by_programme_badge_template_ids(user.id, programme.badges.completion.pluck(:credly_badge_template_id))
    end

    def self.user_has_programme_cpd_badge?(user, programme)
      by_programme_badge_template_ids(user.id, programme.badges.cpd.pluck(:credly_badge_template_id))
    end

    def self.by_programme_badge_template_ids(user_id, template_ids)
      issued = Credly::Badge.issued(user_id)
      badges = issued.keep_if { |badge| template_ids.include?(badge[:badge_template][:id]) }
      return unless badges.any?

      badges.last
    end
  end
end
