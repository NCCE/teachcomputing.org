require 'rails_helper'

RSpec.describe AchievementMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:mail) { AchievementMailer.with(user_id: user.id, activity_id: activity.id).complete }
  let(:subject) { 'Congratulations on completing an activity' }

  describe 'email' do
    it 'renders the headers' do
      expect(mail.subject).to include(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes expected substitutions' do
      expect(mail.body.encoded).to include(activity.title)
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{subject}</title>")
    end
  end
end
