require 'rails_helper'

RSpec.describe SecondaryMailer, type: :mailer do
  let(:user) { create(:user, first_name: 'Tobias') }
  let(:programme) { create(:secondary_certificate) }
  let(:mail) { SecondaryMailer.with(user: user).welcome }

  describe 'welcome' do
    let(:mail_subject) { 'Welcome to Teach secondary computing' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'renders the plain text body' do
      expect(mail.text_part.body.to_s.chomp).to eq(secondary_welcome_text_master)
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end
  end
end
