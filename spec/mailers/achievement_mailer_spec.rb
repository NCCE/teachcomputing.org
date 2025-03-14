require "rails_helper"

RSpec.describe AchievementMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:mail) { described_class.with(user_id: user.id, activity_id: activity.id).complete }
  let(:course_mail) { described_class.with(user_id: user.id).completed_course }
  let(:subject) { "Congratulations on completing an activity" }
  let(:course_subject) { "Take the next step on your subject knowledge certificate" }

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

  describe "completed online course email" do
    it "renders the headers" do
      expect(course_mail.subject).to include(course_subject)
      expect(course_mail.to).to eq([user.email])
      expect(course_mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(course_mail.body.encoded).to include(user.first_name.to_s)
    end

    it "includes the subject in the email" do
      expect(course_mail.body.encoded).to include("<title>#{course_subject}</title>")
    end
  end
end
