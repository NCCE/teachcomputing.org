require 'rails_helper'

RSpec.describe CsAcceleratorMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:mail) { CsAcceleratorMailer.with(user: user, programme: programme).completed }

  describe 'email' do
    it 'renders the headers' do
      expect(mail.subject).to include('Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['teachcomputing@teachcomputing.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.first_name.to_s)
    end
  end
end
