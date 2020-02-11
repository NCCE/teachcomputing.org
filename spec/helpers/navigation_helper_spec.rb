require 'rails_helper'

describe NavigationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:enrolment) { create(:user_programme_enrolment, user: user) }

  describe('#certificate_progress_for_user') do
    context 'when a user is enrolled on a programme' do
      it 'returns a string' do
        enrolment
        expect(helper.certificate_progress_for_user(user)).to be_a(String)
      end
    end

    context 'when a user is not enrolled on a programme' do
      it 'returns nil' do
        expect(helper.certificate_progress_for_user(user)).to eq nil
      end
    end
  end
end
