module CredlyStubs
  def stub_badge_templates
    json_response = File.new('spec/support/credly/badge_templates.json')
    stub_request(:get, 'https://api.credly.com/v1/organizations/e52b9e79-9ddb-4110-9883-ae2c44a7440e/badge_templates').to_return(body: json_response)
  end

  def stub_issue_badge(user_id, template_id)
    json_response = File.new('spec/support/credly/issue_badge.json')
    stub_request(:post, 'https://api.credly.com/v1/organizations/e52b9e79-9ddb-4110-9883-ae2c44a7440e/badges').to_return(body: json_response)
  end

  def stub_issued_badges(user_id)
    json_response = File.new('spec/support/credly/issued_badges.json')
    stub_request(:get, 'https://api.credly.com/v1/organizations/e52b9e79-9ddb-4110-9883-ae2c44a7440e/badges?filter=recipient_email::web@rapsberrypi.org').to_return(body: json_response)
  end
end
