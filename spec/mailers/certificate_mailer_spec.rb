require 'rails_helper'

RSpec.describe CertificateMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let(:mail) { CertificateMailer.with(user: user, programme: programme).completed }

  describe 'email' do
    it 'renders the headers' do
      expect(mail.subject).to eq("Congratulations you have completed #{programme.title}")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end
  end
end
