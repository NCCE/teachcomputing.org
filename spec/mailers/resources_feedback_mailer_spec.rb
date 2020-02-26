require 'rails_helper'

RSpec.describe ResourcesFeedbackMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:mail) { ResourcesFeedbackMailer.with(user: user, year: 1).feedback_request }
  let(:subject) { 'How are you finding the Resource Repository content?' }

  describe 'email' do
    it 'renders the headers' do
      expect(mail.subject).to eq(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'contains the users name' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'contains the correct feedback link' do
      expect(mail.body.encoded).to include('http://ncce.io/year1capture')
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{subject}</title>")
    end
  end
end
