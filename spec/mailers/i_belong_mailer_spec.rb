require "rails_helper"

RSpec.describe IBelongMailer, type: :mailer do
  let(:user) { create(:user, first_name: "Tobias", last_name: "Doe") }

  describe "enrolled" do
    let(:mail) { IBelongMailer.with(user: user).enrolled }
    let(:mail_subject) { "Welcome to I Belong: Encouraging girls into computer science!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias\s*Thank you for signing up/)
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "contains the certificate dashboard link" do
      expect(mail.body.encoded).to have_link("personal dashboard", href: %r{/certificate/i-belong})
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias\s*Thank you for signing up/)
      end
    end
  end

  describe "auto_enrolled" do
    let(:mail) { IBelongMailer.with(user: user).auto_enrolled }
    let(:mail_subject) { "Welcome to I Belong: Encouraging girls into computer science!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*We can see you've been working/)
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "contains the certificate dashboard link" do
      expect(mail.body.encoded).to have_link("Explore activities in your dashboard", href: %r{/certificate/i-belong})
    end

    it "contains the unenroll link" do
      expect(mail.body.encoded).to have_link("Unenrol me from the programme", href: %r{/i_belong/auto_enrolment/unenroll})
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Hi Tobias,\s*We can see you've been working/)
      end
    end
  end

  describe "pending" do
    let(:mail) { IBelongMailer.with(user: user).pending }
    let(:mail_subject) { "Thank you for participating in the I Belong programme" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Thank you for participating in the I Belong programme/)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    it "contains link to student survey" do
      expect(mail.html_part.body.to_s).to have_link("student attitude surveys", href: "https://ncce.io/student-survey")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "contains student survey url" do
        expect(mail.text_part.body.to_s).to match(/https:\/\/ncce.io\/student-survey/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s)
          .to match(/request this by emailing info@teachcomputing.org./)
      end
    end
  end

  describe "completed" do
    let(:mail) { IBelongMailer.with(user: user).completed }
    let(:mail_subject) do
      "Congratulations on your achievement Tobias Doe"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias.*claim your certificate for your school/m)
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "includes link to press pack" do
      expect(mail.html_part.body.to_s).to have_link("Access the pack here",
        href: "https://static.teachcomputing.org/I_Belong_PR_Pack-Editorial_and_Social_Media.pdf")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s)
          .to match(/Any questions\?\s*Please contact info@teachcomputing.org/)
      end

      it "includes url to press pack" do
        expect(mail.text_part.body.to_s)
          .to match(/https:\/\/static.teachcomputing.org\/I_Belong_PR_Pack-Editorial_and_Social_Media.pdf/)
      end
    end
  end
end
