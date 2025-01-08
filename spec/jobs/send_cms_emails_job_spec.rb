require "rails_helper"

RSpec.describe SendCmsEmailsJob, type: :job do
  let(:email_template_1_slug) { "send-cms-email-template-1-slug" }
  let(:email_template_2_slug) { "send-cms-email-template-2-slug" }

  let(:email_template_1) {
    Cms::Mocks::EmailTemplate.generate_raw_data(slug: email_template_1_slug)
  }
  let(:email_template_2) {
    Cms::Mocks::EmailTemplate.generate_raw_data(slug: email_template_2_slug)
  }

  before do
    stub_strapi_email_template(email_template_1_slug, email_template: email_template_1)
    stub_strapi_email_template(email_template_2_slug, email_template: email_template_2)
    stub_strapi_email_templates(email_templates: [email_template_1, email_template_2])
  end

  it "should iterate through templates" do
    described_class.perform_now
  end
end
