require 'rails_helper'

RSpec.describe CSAcceleratorMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:enrolment) { create(:user_programme_enrolment, programme: programme, user: user) }
  let(:completed_mail) { CSAcceleratorMailer.with(user: user, programme: programme).completed }
  let(:completed_subject) do
    'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge'
  end
  let(:eligible_mail) { CSAcceleratorMailer.with(user: user, programme: programme).assessment_eligibility }
  let(:manual_enrolled_welcome_mail) { CSAcceleratorMailer.with(user: user).manual_enrolled_welcome }
  let(:newly_eligible_mail) { CSAcceleratorMailer.with(user: user, programme: programme).new_assessment_eligibility }
  let(:eligible_subject) { "#{user.first_name} your CS Accelerator test is ready." }
  let(:non_enrolled_csa_user_mail) { described_class.with(user: user, programme: programme).non_enrolled_csa_user }
  let(:non_enrolled_csa_user_subject) { 'Time to finish what you’ve started and achieve your qualification' }
  let(:getting_started_prompt) do
    CSAcceleratorMailer.with(user: user, enrolment_id: enrolment.id).getting_started_prompt
  end

  describe '#completed' do
    it 'renders the headers' do
      expect(completed_mail.subject).to include(completed_subject)
      expect(completed_mail.to).to eq([user.email])
      expect(completed_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(completed_mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(completed_mail.body.encoded).to include("<title>#{completed_subject}</title>")
    end
  end

  describe '#assessment_eligibility' do
    it 'renders the headers' do
      expect(eligible_mail.subject).to include(eligible_subject)
      expect(eligible_mail.to).to eq([user.email])
      expect(eligible_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(eligible_mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(eligible_mail.body.encoded).to include("<title>#{eligible_subject}</title>")
    end
  end

  describe '#getting_started_prompt' do
    it 'renders the headers' do
      expect(getting_started_prompt.subject).to include('Kick-start your CPD with our Computer Science Accelerator programme')
      expect(getting_started_prompt.to).to eq([user.email])
      expect(getting_started_prompt.from).to eq(['noreply@teachcomputing.org'])
    end
  end

  describe '#manual_enrolled_welcome' do
    it 'renders the headers' do
      expect(manual_enrolled_welcome_mail.subject).to include('Welcome to our subject knowledge certificate')
      expect(manual_enrolled_welcome_mail.to).to eq([user.email])
      expect(manual_enrolled_welcome_mail.from).to eq(['noreply@teachcomputing.org'])
    end
  end

  describe '#new_assessment_eligibility' do
    it 'renders the headers' do
      expect(newly_eligible_mail.subject).to include(eligible_subject)
      expect(newly_eligible_mail.to).to eq([user.email])
      expect(newly_eligible_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(newly_eligible_mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(newly_eligible_mail.body.encoded).to include("<title>#{eligible_subject}</title>")
    end
  end

  describe '#auto_enrolled_welcome' do
    let(:mail) { described_class.with(user: user).auto_enrolled_welcome }
    let(:mail_subject) { 'Kick-start your CPD with our Computer Science Accelerator programme' }

    it 'renders the headers' do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.html_part.body).to match(/Hi #{user.first_name}/)
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
        .to have_link('Check your eligibility', href: 'https://teachcomputing.org/bursary')
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
        expect(mail.text_part.body).to match(/Hi #{user.first_name},/)
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
          .to match(%r{Check your eligibility https://teachcomputing.org/bursary})
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
