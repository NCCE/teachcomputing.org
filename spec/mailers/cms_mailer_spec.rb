require "rails_helper"

RSpec.describe CmsMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:subject) { "I am a test email" }
  let(:slug) { "test-email-slug" }
  let(:mail) { CmsMailer.with(user_id: user.id, template_slug: slug).send_template }
  let(:email_content) {
    [
      {
        type: :paragraph,
        children: [
          {type: :text, text: "Hello {first_name}"}
        ]
      },
      {
        type: "paragraph",
        children: [
          {text: "This is a random paragraph with a ", type: "text"},
          {
            url: "https://www.google.com",
            type: "link",
            children: [{text: "link", type: "text"}]
          },
          {
            text: ".",
            type: "text"
          }
        ]
      }
    ]
  }
  let(:email_template) {
    Cms::Mocks::EmailTemplate.generate_raw_data(
      subject:,
      slug:,
      email_content:
    )
  }

  before do
    stub_strapi_email_template(slug, email_template:)
  end

  describe "send_template" do
    it "renders the headers" do
      expect(mail.subject).to include(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders name in html_body" do
      expect(mail.html_part.body).to include(user.first_name.to_s)
    end

    it "renders name in text_body" do
      expect(mail.text_part.body).to include(user.first_name.to_s)
    end

    it "renders link correctly in html_body" do
      expect(mail.html_part.body).to have_link("link", href: "https://www.google.com")
    end

    it "renders link correctly in text_body" do
      expect(mail.text_part.body).to include("with a link (https://www.google.com)")
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{subject}</title>")
    end
  end
end
