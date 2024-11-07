require "rails_helper"

RSpec.describe CmsMailer, type: :mailer do
  let(:programme) { create(:primary_certificate) }
  let(:user) { create(:user) }
  let(:activity) { create(:activity, programmes: [programme], title: "Test activity") }
  let(:second_activity) { create(:activity, programmes: [programme], title: "Test activity second") }
  let!(:achievement) { create(:completed_achievement, activity:, user:) }
  let(:subject) { "I am a test email" }
  let(:slug) { "test-email-slug" }
  let(:email_content) {
    [
      {
        __component: "email-content.text",
        textContent: [
          {
            type: :paragraph,
            children: [
              {type: :text, text: "Hello {first_name}"}
            ]
          },
          {
            type: :paragraph,
            children: [
              {type: :text, text: "You completed {last_cpd_title}"}
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
      },
      {
        __component: "email-content.cta",
        text: "CTA 1",
        link: "https://teachcomputing.org/cta1"
      },
      {
        __component: "email-content.cta",
        text: "CTA 2",
        link: "https://teachcomputing.org/cta2"
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
    @mail = CmsMailer.with(user_id: user.id, template_slug: slug).send_template
  end

  describe "send_template" do
    it "renders the headers" do
      expect(@mail.subject).to include(subject)
      expect(@mail.to).to eq([user.email])
      expect(@mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders name in html_body" do
      expect(@mail.html_part.body).to include(user.first_name.to_s)
    end

    it "renders name in text_body" do
      expect(@mail.text_part.body).to include(user.first_name.to_s)
    end

    it "renders activity title in html_body" do
      expect(@mail.html_part.body).to include("You completed #{activity.title}")
    end

    it "renders activity title in text_body" do
      expect(@mail.text_part.body).to include("You completed #{activity.title}")
    end

    it "renders link correctly in html_body" do
      expect(@mail.html_part.body).to have_link("link", href: "https://www.google.com")
    end

    it "renders link correctly in text_body" do
      expect(@mail.text_part.body).to include("with a link (https://www.google.com)")
    end

    it "renders ctas in html_body" do
      expect(@mail.html_part.body).to have_link("CTA 1", href: "https://teachcomputing.org/cta1")
      expect(@mail.html_part.body).to have_link("CTA 2", href: "https://teachcomputing.org/cta2")
    end

    it "renders ctas in text_body" do
      expect(@mail.text_part.body).to include("CTA 1 (https://teachcomputing.org/cta1)")
      expect(@mail.text_part.body).to include("CTA 2 (https://teachcomputing.org/cta2)")
    end

    it "includes the subject in the email" do
      expect(@mail.body.encoded).to include("<title>#{subject}</title>")
    end

    describe "Newer achievement" do
      before do
        travel_to 1.day.from_now do
          create(:completed_achievement, activity: second_activity, user:)
          @future_mail = CmsMailer.with(user_id: user.id, template_slug: slug).send_template
        end
      end

      it "renders activity title in html_body" do
        expect(@future_mail.html_part.body).to include("You completed #{second_activity.title}")
      end

      it "renders activity title in text_body" do
        expect(@future_mail.text_part.body).to include("You completed #{second_activity.title}")
      end
    end
  end
end
