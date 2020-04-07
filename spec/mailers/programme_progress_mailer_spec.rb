require 'rails_helper'

RSpec.describe ProgrammeProgressMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:mail) { ProgrammeProgressMailer.with(user: user, slug: programme.slug).get_started_prompt }
  let(:subject) { 'Thanks for enrolling, do you need some help getting started?' }

  describe 'email' do
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
