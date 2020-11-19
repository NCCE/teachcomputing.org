require 'rails_helper'

RSpec.describe CSAAutoEnrolmentMailer, type: :mailer do
  let(:user) { create(:user, first_name: 'Tobias') }

  describe 'welcome' do
    let(:mail) { described_class.with(user: user).welcome }
    let(:mail_subject) { 'Kick-start your CPD with our Computer Science Accelerator programme' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/Hi Tobias/)
    end

    it 'contains link to teachcomputing' do
      expect(mail.html_part.body)
        .to have_link('TeachComputing.org', href: 'https://teachcomputing.org/')
    end

    it 'contains link to handbook' do
      expect(mail.html_part.body)
        .to have_link('handbook', href: 'http://ncce.io/csa-handbook')
    end

    it 'contains link to dashboard' do
      expect(mail.html_part.body)
        .to have_link('Explore your dashboard', href: cs_accelerator_certificate_url)
    end

    it 'contains link to bursary' do
      expect(mail.html_part.body)
        .to have_link('Check your eligibility', href: bursary_url)
    end

    it 'contains mail_to link' do
      expect(mail.html_part.body)
        .to have_link(
          'CSChampionSupport@stem.org.uk',
          href: 'mailto:CSChampionSupport@stem.org.uk'
        )
    end

    it 'contains opt-out link' do
      expect(mail.html_part.body)
        .to have_link('let us know',
                      href: unenroll__cs_accelerator_auto_enrolment_url)
    end

    it 'contains link to cs_accelerator' do
      expect(mail.html_part.body)
        .to have_link('on our website', href: cs_accelerator_url)
    end

    it 'includes the subject in the email' do
      expect(mail.html_part.body).to include("<title>#{mail_subject}</title>")
    end

    context 'when viewing plain text' do
      it 'greets the user' do
        expect(mail.text_part.body).to match(/Hi Tobias,/)
      end

      it 'contains link to teachcomputing' do
        expect(mail.text_part.body)
          .to match(%r{TeachComputing.org. \(https://teachcomputing.org/\)})
      end

      it 'contains link to handbook' do
        expect(mail.text_part.body)
          .to match(%r{handbook \(http://ncce.io/csa-handbook\)})
      end

      it 'contains link to dashboard' do
        expect(mail.text_part.body)
          .to match(/Explore your dashboard \(#{cs_accelerator_certificate_url}\)/)
      end

      it 'contains link to bursary' do
        expect(mail.text_part.body)
          .to match(/Check your eligibility \(#{bursary_url}\)/)
      end

      it 'contains mail_to link' do
        expect(mail.text_part.body)
          .to match(/Contact CSChampionSupport@stem.org.uk/)
      end

      it 'contains opt-out link' do
        expect(mail.text_part.body)
          .to match(/let us know \(#{unenroll__cs_accelerator_auto_enrolment_url}\)/)
      end

      it 'contains link to cs_accelerator' do
        expect(mail.text_part.body)
          .to match(/on our website \(#{cs_accelerator_url}\)/)
      end
    end
  end
end
