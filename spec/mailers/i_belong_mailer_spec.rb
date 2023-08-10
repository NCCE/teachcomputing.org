require 'rails_helper'

RSpec.describe IBelongMailer, type: :mailer do
  let(:user) { create(:user, first_name: 'Tobias', last_name: 'Doe') }

  describe 'welcome' do
    let(:mail) { IBelongMailer.with(user: user).welcome }
    let(:mail_subject) { 'Welcome to I Belong: Encouraging girls into computer science!' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Dear Tobias\s*Thank you for signing up/)
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it 'contains the certificate dashboard link' do
      expect(mail.body.encoded).to have_link('personal dashboard', href: %r{/certificate/i-belong-certificate})
    end

    context 'when viewing plain text' do
      it 'greets the user' do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias\s*Thank you for signing up/)
      end
    end
  end

  describe 'pending' do
    let(:mail) { IBelongMailer.with(user: user).pending }
    let(:mail_subject) { 'Thank you for participating in the I Belong programme' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Thank you for participating in the I Belong programme/)
    end

    it 'includes the subject in the email' do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it 'contains mail_to link' do
      expect(mail.html_part.body.to_s).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
    end

    context 'when viewing plain text' do
      it 'greets the user' do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it 'includes email address' do
        expect(mail.text_part.body.to_s)
          .to match(/Get in touch by emailing info@teachcomputing.org./)
      end
    end
  end

  describe 'completed' do
    let(:mail) { IBelongMailer.with(user: user).completed }
    let(:mail_subject) do
      'Congratulations on your achievement Tobias Doe'
    end

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Dear Tobias.*claim your certificate for your school/m)
    end

    it 'contains mail_to link' do
      expect(mail.html_part.body.to_s).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
    end

    it 'includes the subject in the email' do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    context 'when viewing plain text' do
      it 'greets the user' do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it 'includes email address' do
        expect(mail.text_part.body.to_s)
          .to match(/Any questions\?\s*Please contact info@teachcomputing.org/)
      end
    end
  end
end
