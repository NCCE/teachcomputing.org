require 'rails_helper'

RSpec.describe UserDetail, type: :model do
  let(:user_detail) do
    UserDetail.create(stem_user_id: '1234',
                      stem_credentials_access_token: '123-token',
                      stem_credentials_refresh_token: '123-refresh-token')
  end

  it { is_expected.to validate_uniqueness_of(:stem_user_id) }

  describe 'encryption' do
    it 'encrypts stem_credentials_access_token' do
      expect(user_detail.stem_credentials_access_token).not_to be_nil
      expect(user_detail.encrypted_stem_credentials_access_token).not_to eq user_detail.stem_credentials_access_token
    end

    it 'encrypts stem_credentials_refresh_token' do
      expect(user_detail.stem_credentials_refresh_token).not_to be_nil
      expect(user_detail.encrypted_stem_credentials_refresh_token).not_to eq user_detail.stem_credentials_refresh_token
    end
  end
end
