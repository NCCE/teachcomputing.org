require "rails_helper"

RSpec.describe NewBadgeMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate, title: "My title") }
  let(:mail) { NewBadgeMailer.new_badge_email(user, programme) }
  let(:subject) { "You’ve been awarded a new digital badge" }

  describe "email" do
    it "renders the headers" do
      expect(mail.subject).to include(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(user.first_name.to_s)
      expect(mail.body.encoded).to include("My title")
    end
  end
end
