require "rails_helper"

RSpec.describe CSAcceleratorMailer, type: :mailer do
  include ExternalLinkHelper

  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:enrolment) { create(:user_programme_enrolment, programme: programme, user: user) }
  let(:completed_mail) { CSAcceleratorMailer.with(user: user, programme: programme).completed }
  let(:completed_subject) do
    "Congratulations you have completed the Key stage 3 and GCSE Computer Science certificate from the National Centre for Computing Education"
  end
  let(:eligible_mail) { CSAcceleratorMailer.with(user: user, programme: programme).assessment_eligibility }
  let(:enrolled_mail) { CSAcceleratorMailer.with(user: user).enrolled }
  let(:eligible_subject) { "#{user.first_name} your Key stage 3 and GCSE Computer Science test is ready." }
  let(:non_enrolled_csa_user_mail) { described_class.with(user: user, programme: programme).non_enrolled_csa_user }
  let(:non_enrolled_csa_user_subject) { "Time to finish what you’ve started and achieve your qualification" }
  let(:getting_started_prompt) do
    CSAcceleratorMailer.with(user: user, enrolment_id: enrolment.id).getting_started_prompt
  end

  describe "#completed" do
    it "renders the headers" do
      expect(completed_mail.subject).to include(completed_subject)
      expect(completed_mail.to).to eq([user.email])
      expect(completed_mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(completed_mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes the subject in the email" do
      expect(completed_mail.body.encoded).to include("<title>#{completed_subject}</title>")
    end
  end

  describe "#assessment_eligibility" do
    it "renders the headers" do
      expect(eligible_mail.subject).to include(eligible_subject)
      expect(eligible_mail.to).to eq([user.email])
      expect(eligible_mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(eligible_mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes the subject in the email" do
      expect(eligible_mail.body.encoded).to include("<title>#{eligible_subject}</title>")
    end
  end

  describe "#getting_started_prompt" do
    it "renders the headers" do
      expect(getting_started_prompt.subject).to include("Kick-start your CPD and achieve a national qualification")
      expect(getting_started_prompt.to).to eq([user.email])
      expect(getting_started_prompt.from).to eq(["noreply@teachcomputing.org"])
    end
  end

  describe "#enrolled" do
    it "renders the headers" do
      expect(enrolled_mail.subject).to include("Welcome to our KS3 and GCSE Computer Science subject knowledge certificate")
      expect(enrolled_mail.to).to eq([user.email])
      expect(enrolled_mail.from).to eq(["noreply@teachcomputing.org"])
    end
  end

  describe "#auto_enrolled" do
    let(:mail) { described_class.with(user: user).auto_enrolled }
    let(:mail_subject) { "Achieve your subject knowledge certificate with the Key stage 3 and GCSE Computer Science certificate" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.html_part.body).to match(/Hi #{user.first_name}/)
    end

    it "contains link to teachcomputing" do
      expect(mail.html_part.body)
        .to have_link("TeachComputing.org", href: root_url)
    end

    it "contains link to handbook" do
      expect(mail.html_part.body)
        .to have_link("handbook", href: csa_handbook_url)
    end

    it "contains link to dashboard" do
      expect(mail.html_part.body)
        .to have_link("Explore your dashboard", href: cs_accelerator_certificate_url)
    end

    it "contains link to funding" do
      expect(mail.html_part.body)
        .to have_link("for a subsidy", href: cms_post_url("funding"))
    end

    it "contains opt-out link" do
      expect(mail.html_part.body)
        .to have_link("let us know",
          href: unenroll__cs_accelerator_auto_enrolment_url)
    end

    it "contains link to cs_accelerator" do
      expect(mail.html_part.body)
        .to have_link("on our website", href: cs_accelerator_url)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body).to include("<title>#{mail_subject}</title>")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body).to match(/Hi #{user.first_name},/)
      end

      it "contains link to teachcomputing" do
        expect(mail.text_part.body)
          .to include("TeachComputing.org (#{root_url})")
      end

      it "contains link to handbook" do
        expect(mail.text_part.body)
          .to include("handbook (#{csa_handbook_url})")
      end

      it "contains link to dashboard" do
        expect(mail.text_part.body)
          .to match(/Explore your dashboard \(#{cs_accelerator_certificate_url}\)/)
      end

      it "contains link to bursary" do
        expect(mail.text_part.body)
          .to include("eligible for a subsidy (#{cms_post_url("funding", anchor: "secondary-subsidy")})")
      end

      it "contains opt-out link" do
        expect(mail.text_part.body)
          .to match(/let us know, \(#{unenroll__cs_accelerator_auto_enrolment_url}\)/)
      end

      it "contains link to cs_accelerator" do
        expect(mail.text_part.body)
          .to match(/on our website \(#{cs_accelerator_url}\)/)
      end
    end
  end
end
