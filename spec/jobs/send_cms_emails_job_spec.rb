require "rails_helper"

RSpec.describe SendCmsEmailsJob, type: :job do
  let(:email_template_1_slug) { "send-cms-email-template-1-slug" }
  let(:email_template_2_slug) { "send-cms-email-template-2-slug" }
  let(:users) { create_list(:user, 2) }

  let(:email_template_1) {
    Cms::Mocks::EmailTemplate.generate_raw_data(slug: email_template_1_slug)
  }
  let(:email_template_2) {
    Cms::Mocks::EmailTemplate.generate_raw_data(slug: email_template_2_slug)
  }

  before do
    stub_strapi_email_template(email_template_1_slug, email_template: email_template_1)
    stub_strapi_email_template(email_template_2_slug, email_template: email_template_2)
    stub_strapi_email_templates(email_templates: [email_template_1, email_template_2], page: 1, page_size: 50)

    allow_any_instance_of(Programmes::ProgressQuery).to receive(:call).and_return(users)
  end

  it "should enqueue both templates" do
    expect do
      described_class.perform_now
    end.to have_enqueued_mail(CmsMailer, :send_template).with(a_hash_including(params: {user_id: users.first.id, template_slug: email_template_1_slug}))
      .and have_enqueued_mail(CmsMailer, :send_template).with(a_hash_including(params: {user_id: users.first.id, template_slug: email_template_2_slug}))
      .and have_enqueued_mail(CmsMailer, :send_template).with(a_hash_including(params: {user_id: users.second.id, template_slug: email_template_1_slug}))
      .and have_enqueued_mail(CmsMailer, :send_template).with(a_hash_including(params: {user_id: users.second.id, template_slug: email_template_2_slug}))
  end
end
