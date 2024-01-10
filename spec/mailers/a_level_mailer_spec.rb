require "rails_helper"

RSpec.describe ALevelMailer, type: :mailer do
  let(:user) { create(:user, first_name: "Tobias", last_name: "Doe") }

  describe "welcome" do
    let(:mail) { ALevelMailer.with(user: user).welcome }
    let(:mail_subject) { "Welcome to A level subject knowledge!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end
  end

  describe "completed" do
    let(:mail) { ALevelMailer.with(user: user).completed }
    let(:mail_subject) do
      "Congratulations on your achievement Tobias Doe"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end
  end
end
