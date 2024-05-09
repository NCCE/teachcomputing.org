require "rails_helper"

RSpec.describe IBelongMailer, type: :mailer do
  let(:user) { create(:user, first_name: "Tobias", last_name: "Doe") }
  let(:programme) { create(:i_belong) }

  before do
    programme
  end

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

  describe "inactive_not_completed_any_sections" do
    let(:mail) { IBelongMailer.with(user: user).inactive_not_completed_any_sections }
    let(:mail_subject) do
      "Reminder: update your progress on the I Belong programme"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*It's been a while since you updated/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end
    end
  end

  describe "inactive_only_completed_one_section" do
    let(:mail) { IBelongMailer.with(user: user).inactive_only_completed_one_section }
    let(:mail_subject) do
      "Reminder: update your progress on the I Belong programme"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*It's been a while since you updated/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end
    end
  end

  describe "inactive_everything_but_understanding_factors" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_understanding_factors }
    let(:mail_subject) do
      "You're nearly there"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end
    end
  end

  describe "inactive_everything_but_access_resources" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_access_resources }
    let(:mail_subject) do
      "You're so close"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end
    end
  end

  describe "inactive_everything_but_increase_engagement" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_increase_engagement }
    let(:mail_subject) do
      "You're almost there"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render handbook link" do
        expect(mail.html_part.body).to have_link("View recommended activities in your handbook", href: "https://static.teachcomputing.org/I+Belong+Handbook.pdf")
      end
    end

    describe "when text" do
      it "should render action plan link" do
        expect(mail.text_part.body).to include("View recommended activities in you handbook (https://static.teachcomputing.org/I+Belong+Handbook.pdf)")
      end
    end
  end
end
