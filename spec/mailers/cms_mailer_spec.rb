require "rails_helper"

RSpec.describe CmsMailer, type: :mailer do
  let(:programme) { create(:primary_certificate) }
  let(:user) { create(:user) }
  let(:activity) { create(:activity, programmes: [programme], title: "Test activity") }
  let!(:second_activity) { create(:activity, programmes: [programme], title: "Test activity second") }
  let!(:other_activity) { create(:activity, programmes: [programme], title: "Other activity") }
  let!(:achievement) { create(:completed_achievement, activity:, user:) }
  let(:subject) { "I am a test email" }
  let(:slug) { "test-email-slug" }
  let(:slug_with_merge_subject) { "test-email-subject-merge" }
  let(:email_content) {
    [
      Cms::Mocks::EmailComponents::Text.generate_raw_data(
        text_content: [
          {
            type: "paragraph",
            children: [
              {type: "text", text: "Hello {first_name}"}
            ]
          },
          {
            type: "paragraph",
            children: [
              {type: "text", text: "You completed {last_cpd_title}"}
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
      ),
      Cms::Mocks::EmailComponents::Cta.generate_raw_data(text: "CTA 1", link: "https://teachcomputing.org/cta1"),
      Cms::Mocks::EmailComponents::Cta.generate_raw_data(text: "CTA 2", link: "https://teachcomputing.org/cta2"),
      Cms::Mocks::EmailComponents::CourseList.generate_raw_data(section_title: nil, courses: [
        Cms::Mocks::EmailComponents::Course.generate_data(activity_code: other_activity.stem_activity_code)
      ])
    ]
  }
  let(:email_template) {
    Cms::Mocks::Collections::EmailTemplate.generate_raw_data(
      subject:,
      slug:,
      email_content:
    )
  }
  let(:email_template_merge_subject) {
    Cms::Mocks::Collections::EmailTemplate.generate_raw_data(
      subject: "Congrats {first_name} you did {last_cpd_title}",
      slug: slug_with_merge_subject,
      email_content:
    )
  }

  before do
    stub_strapi_email_template(slug, email_template:)
    stub_strapi_email_template(slug_with_merge_subject, email_template: email_template_merge_subject)
  end

  describe "send_template" do
    before do
      @mail = described_class.with(user_id: user.id, template_slug: slug).send_template
    end

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

    it "renders course link in html part" do
      expect(@mail.html_part.body).to have_link(other_activity.title, href: /#{other_activity.stem_activity_code}/)
    end

    it "renders course link in text part" do
      expect(@mail.text_part.body).to include("#{other_activity.title} (http://teachcomputing.test/courses/#{other_activity.stem_activity_code}/#{other_activity.title.parameterize})")
    end

    describe "Newer achievement" do
      before do
        travel_to 1.day.from_now do
          create(:completed_achievement, activity: second_activity, user:)
          @future_mail = described_class.with(user_id: user.id, template_slug: slug).send_template
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

  describe "send_template with merged subject" do
    before do
      @mail = described_class.with(user_id: user.id, template_slug: slug_with_merge_subject).send_template
    end

    it "renders the headers" do
      expect(@mail.subject).to include("Congrats #{user.first_name} you did #{activity.title}")
      expect(@mail.to).to eq([user.email])
      expect(@mail.from).to eq(["noreply@teachcomputing.org"])
    end
  end

  describe "with missing template" do
    let(:missing_slug) { "missing_template_slug" }

    before do
      stub_strapi_email_template_missing(missing_slug)
      allow(Sentry).to receive(:capture_message)
    end

    it "logs error to sentry" do
      described_class.with(user_id: user.id, template_slug: missing_slug).send_template.deliver_now
      expect(Sentry)
        .to have_received(:capture_message)
        .with("Failed to load the email template #{missing_slug}")
    end
  end

  describe "with user who already received the email" do
    let(:sent_email) { create(:sent_email, user:, mailer_type: slug, subject:) }

    before do
      sent_email
    end

    it "does not send the email" do
      @mail = described_class.with(user_id: user.id, template_slug: slug).send_template

      expect {
        @mail.deliver_now
      }.not_to change { ActionMailer::Base.deliveries.count }
    end
  end

  describe "sent email tracking" do
    before do
      described_class.with(user_id: user.id, template_slug: slug).send_template.deliver_now
    end

    it "records the correct details in sent email" do
      sent_email = SentEmail.last
      expect(sent_email.user).to eq(user)
      expect(sent_email.mailer_type).to eq(slug)
      expect(sent_email.subject).to eq(subject)
    end
  end
end
