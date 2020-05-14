require 'rails_helper'

RSpec.describe CsAcceleratorMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:completed_mail) { CsAcceleratorMailer.with(user: user, programme: programme).completed }
  let(:completed_subject) { 'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge' }
  let(:eligible_mail) { CsAcceleratorMailer.with(user: user, programme: programme).assessment_eligibility }
  let(:newly_eligible_mail) { CsAcceleratorMailer.with(user: user, programme: programme).new_assessment_eligibility }
  let(:eligible_subject) { "#{user.first_name.to_s} your CS Accelerator test is ready." }
  let(:non_enrolled_csa_user_mail) { CsAcceleratorMailer.with(user: user, programme: programme).non_enrolled_csa_user }
  let(:non_enrolled_csa_user_subject) { "Time to finish what you’ve started and achieve your qualification" }


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

  describe '#non_enrolled_csa_user' do
    it 'renders the headers' do
      expect(non_enrolled_csa_user_mail.subject).to include(non_enrolled_csa_user_subject)
      expect(non_enrolled_csa_user_mail.to).to eq([user.email])
      expect(non_enrolled_csa_user_mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(non_enrolled_csa_user_mail.body.encoded).to include(user.first_name.to_s)
    end

    it 'includes the subject in the email' do
      expect(non_enrolled_csa_user_mail.body.encoded).to include("<title>#{non_enrolled_csa_user_subject}</title>")
    end
  end
end
