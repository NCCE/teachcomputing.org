require 'rails_helper'

RSpec.describe(User, type: :class) do
  let(:session) do
    {
      id: uid,
      first_name: 'Jane',
      last_name: 'Doe',
      email: 'user@example.com',
      stem_achiever_contact_no: '123456',
      stem_credentials_access_token: '123-token',
      stem_credentials_refresh_token: '123-refresh-token',
      stem_credentials_expires_at: '1546601180'
    }
  end
  let(:stem_credentials) do
    OmniAuth::AuthHash.new(expires: true,
                           expires_at: '1546601180',
                           refresh_token: '123-refresh-token',
                           token: '123-token')
  end
  let(:stem_info) do
    OmniAuth::AuthHash::InfoHash.new(achiever_contact_no: '123456',
                                     email: 'user@example.com',
                                     first_name: 'Jane',
                                     last_name: 'Doe')
  end
  let(:user_from_session) { User.from_session(session.stringify_keys) }
  let(:uid) { '987654321' }
  let(:user_from_auth) do
    User.from_auth(uid,
                   stem_credentials,
                   stem_info)
  end

  describe '#from_auth' do
    it 'has the correct id' do
      expect(user_from_auth.id).to eq uid
    end

    it 'has the correct first name' do
      expect(user_from_auth.first_name).to eq 'Jane'
    end

    it 'has the correct last name' do
      expect(user_from_auth.last_name).to eq 'Doe'
    end

    it 'has the correct email' do
      expect(user_from_auth.email).to eq 'user@example.com'
    end

    it 'has the correct achiver contact number' do
      expect(user_from_auth.stem_achiever_contact_no).to eq '123456'
    end

    it 'has the correct token' do
      expect(user_from_auth.stem_credentials_access_token).to eq '123-token'
    end

    it 'has the correct refresh token' do
      expect(user_from_auth.stem_credentials_refresh_token).to eq '123-refresh-token'
    end

    it 'has the correct expires at' do
      expect(user_from_auth.stem_credentials_expires_at).to eq '1546601180'
    end
  end

  describe '#from_session' do
    it 'has the correct id' do
      expect(user_from_session.id).to eq uid
    end

    it 'has the correct first name' do
      expect(user_from_session.first_name).to eq 'Jane'
    end

    it 'has the correct last name' do
      expect(user_from_session.last_name).to eq 'Doe'
    end

    it 'has the correct email' do
      expect(user_from_session.email).to eq 'user@example.com'
    end

    it 'has the correct achiver contact number' do
      expect(user_from_session.stem_achiever_contact_no).to eq '123456'
    end

    it 'has the correct token' do
      expect(user_from_session.stem_credentials_access_token).to eq '123-token'
    end

    it 'has the correct refresh token' do
      expect(user_from_session.stem_credentials_refresh_token).to eq '123-refresh-token'
    end

    it 'has the correct expires at' do
      expect(user_from_session.stem_credentials_expires_at).to eq '1546601180'
    end
    context 'when session is not set' do
      it 'returns nil' do
        expect(User.from_session(nil)).to eq nil
      end
    end
  end

  describe '#set_or_create_user' do
    context 'when a UserDetail record is found' do
      let(:user) { user_from_auth }

      before do
        user = user_from_auth
        user.set_or_create_user
      end

      it 'does not create a record' do
        expect(UserDetail.count).to eq 1
      end
    end

    context 'when a UserDetail record is not found' do
      it 'creates it' do
        user = user_from_auth
        user.set_or_create_user
        expect(UserDetail.last.stem_user_id).to eq user.id
      end
    end
  end
end
