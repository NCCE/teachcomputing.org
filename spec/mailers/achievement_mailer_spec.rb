require "rails_helper"

RSpec.describe AchievementMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:mail) { described_class.with(user_id: user.id, activity_id: activity.id).complete }
  let(:face_to_face_mail) { described_class.with(user_id: user.id).completed_face_to_face_course }
  let(:online_mail) { described_class.with(user_id: user.id).completed_online_course }
  let(:subject) { "Congratulations on completing an activity" }
  let(:face_to_face_subject) { "Take the next step on your subject knowledge certificate" }
  let(:online_subject) { "Keep going with your subject knowledge certificate" }

  describe "email" do
    it "renders the headers" do
      expect(mail.subject).to include(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes expected substitutions" do
      expect(mail.body.encoded).to include(activity.title)
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{subject}</title>")
    end
  end

  describe "completed face to face course email" do
    it "renders the headers" do
      expect(face_to_face_mail.subject).to include(face_to_face_subject)
      expect(face_to_face_mail.to).to eq([user.email])
      expect(face_to_face_mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(face_to_face_mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes the subject in the email" do
      expect(face_to_face_mail.body.encoded).to include("<title>#{face_to_face_subject}</title>")
    end
  end

  describe "completed online course email" do
    it "renders the headers" do
      expect(online_mail.subject).to include(online_subject)
      expect(online_mail.to).to eq([user.email])
      expect(online_mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(online_mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes the subject in the email" do
      expect(online_mail.body.encoded).to include("<title>#{online_subject}</title>")
    end
  end
end
