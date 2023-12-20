require 'rails_helper'

RSpec.describe PrimaryMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:mail) { PrimaryMailer.with(user: user, programme: programme).completed }
  let(:enrolled_mail) { PrimaryMailer.with(user: user, programme: programme).enrolled }
  let(:inactive_prompt_mail) { PrimaryMailer.with(user: user, programme: programme).inactive_prompt }
  let(:subject) { 'Congratulations you have completed the National Centre for Computing Education Certificate in Primary Computing Teaching' }
  let(:enrolled_subject) { 'Welcome to Teach primary computing' }
  let(:inactive_prompt_subject) { 'Kick-start your development and achieve a national qualification' }

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
      expect(enrolled_mail.body.encoded).to have_link(href: hubs_url)
      expect(enrolled_mail.body.encoded).to have_link(href: cms_page_url('funding', anchor: '#primary-subsidy'))
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
      expect(mail.body.encoded).to include("Congratulations on achieving your certificate!")
    end
  end

  describe 'inactive certificate email' do
    it 'renders the headers' do
      expect(inactive_prompt_mail.subject).to include(inactive_prompt_subject)
      expect(inactive_prompt_mail.to).to eq([user.email])
      expect(inactive_prompt_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(inactive_prompt_mail.body.encoded).to include(user.first_name.to_s)
      expect(inactive_prompt_mail.body.encoded).to include("Not sure where to start?")
    end
  end

  describe 'pending' do
    let(:user) { create(:user, first_name: 'Tobias') }
    let(:mail) { PrimaryMailer.with(user: user).pending }
    let(:mail_subject) { 'Well done - you’ve completed Teach primary computing and we’re checking your activities' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Dear Tobias/)
    end

    it 'includes the subject in the email' do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it 'contains mail_to link' do
      expect(mail.html_part.body.to_s).to have_link('info@teachcomputing', href: 'mailto:info@teachcomputing.org')
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

  describe 'completed_cpd_not_activities' do
    let(:user) { create(:user, first_name: 'Tobias') }
    let(:mail) { PrimaryMailer.with(user: user).completed_cpd_not_activities }
    let(:mail_subject) { "You're so close!" }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Dear Tobias/)
    end

    it 'includes the subject in the email' do
      expect(mail.html_part.body.to_s).to include("<title>#{CGI::escape_html(mail_subject)}</title>")
    end

    it 'contains link to dashboard' do
      expect(mail.html_part.body.to_s).to have_link('Check your dashboard', href: primary_certificate_url)
    end

    context 'when viewing plain text' do
      it 'greets the user' do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it 'includes email address' do
        expect(mail.text_part.body.to_s)
          .to include("Check your dashboard (#{primary_certificate_url})")
      end
    end
  end
end
