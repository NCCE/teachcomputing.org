require 'rails_helper'

RSpec.describe PrimaryMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:mail) { PrimaryMailer.with(user: user, programme: programme).completed }
  let(:enrolled_mail) { PrimaryMailer.with(user: user, programme: programme).enrolled }
  let(:subject) { 'Congratulations you have completed the National Centre for Computing Education Certificate in Primary Computing Teaching' }
  let(:enrolled_subject) { 'Welcome to Teach primary computing' }

  describe 'enrolled certificate email' do
    it 'renders the headers' do
      expect(enrolled_mail.subject).to include(enrolled_subject)
      expect(enrolled_mail.to).to eq([user.email])
      expect(enrolled_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(enrolled_mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(enrolled_mail.body.encoded).to include("<title>#{enrolled_subject}</title>")
    end

    it 'includes the correct links in the email' do
      expect(enrolled_mail.body.encoded).to have_link(href: primary_certificate_url)
      expect(enrolled_mail.body.encoded).to have_link(href: 'https://teachcomputing.org/hubs')
    end
  end

  describe 'completed certificate email' do
    it 'renders the headers' do
      expect(mail.subject).to include(subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{subject}</title>")
    end
  end
end
