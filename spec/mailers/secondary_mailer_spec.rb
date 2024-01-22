require "rails_helper"

RSpec.describe SecondaryMailer, type: :mailer do
  let(:user) { create(:user, first_name: "Tobias") }

  describe "enrolled" do
    let(:mail) { SecondaryMailer.with(user: user).enrolled }
    let(:mail_subject) { "Welcome to Teach secondary computing" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Welcome to Teach secondary computing certificate, Tobias/)
    end

    it "contains mail_to link" do
      expect(mail.body.encoded).to have_link("info@teachcomputing", href: "mailto:info@teachcomputing.org")
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Welcome to Teach secondary computing certificate, Tobias/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s).to match(/Get in touch by emailing info@teachcomputing.org./)
      end
    end
  end

  describe "completed" do
    let(:mail) { SecondaryMailer.with(user: user).completed }
    let(:mail_subject) do
      "Congratulations you have completed the Teach secondary computing certificate from the National Centre for Computing Education"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias/)
    end

    it "contains mail_to link" do
      expect(mail.body.encoded).to have_link("info@teachcomputing", href: "mailto:info@teachcomputing.org")
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s)
          .to match(/please contact info@teachcomputing.org if you have any questions./)
      end
    end
  end

  describe "pending" do
    let(:mail) { SecondaryMailer.with(user: user).pending }
    let(:mail_subject) { "Well done - you’ve completed Teach secondary computing and we’re checking your activities" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias/)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing", href: "mailto:info@teachcomputing.org")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s)
          .to match(/Get in touch by emailing info@teachcomputing.org./)
      end
    end
  end

  describe "completed_cpd_not_activities" do
    let(:mail) { SecondaryMailer.with(user: user).completed_cpd_not_activities }
    let(:mail_subject) { "You're so close!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias/)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body.to_s).to include("<title>#{CGI.escape_html(mail_subject)}</title>")
    end

    it "contains link to dashboard" do
      expect(mail.html_part.body.to_s).to have_link("Check your dashboard", href: secondary_certificate_url)
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s)
          .to include("Check your dashboard (#{secondary_certificate_url})")
      end
    end
  end
end
