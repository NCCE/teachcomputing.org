require 'rails_helper'

RSpec.describe Api::UsersController do
  let(:user) { create(:user) }
  let(:achievement) { create(:achievement, user: user) }
  let(:activity) { create(:activity) }
  let(:programme) { create(:programme) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }
  let(:achievement) { create(:achievement, user: user, programme: programme) }
  let(:token_headers) { { HTTP_AUTHORIZATION: 'Bearer secret', HTTP_CONTENT_TYPE: 'application/json' } }

  context 'token is not passed' do
    describe 'GET #show' do
      before do
        get '/api/users/', { params: { email: user.email }, headers: nil }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when the correct token is passed' do
    describe 'GET #show' do
      before do
        enrolment
        achievement
        get '/api/users/', { params: { email: user.email }, headers: token_headers }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 200
      end

      it 'returns the users information' do
        expect(JSON.parse(response.body)['id']).to eq user.id
        expect(JSON.parse(response.body)['email']).to eq user.email
        expect(JSON.parse(response.body)['stem_achiever_contact_no']).to eq user.stem_achiever_contact_no
      end

      it 'contains the users achievements' do
        expect(JSON.parse(response.body)['achievements'].count).to eq 1
      end

      it 'contains the users enrolments' do
        expect(JSON.parse(response.body)['enrolments'].count).to eq 1
      end
    end

    describe 'GET #forget' do
      before do
        enrolment
        achievement
        get '/api/users/forget', { params: { email: user.email }, headers: token_headers }
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'updates the email address' do
        expect(JSON.parse(response.body)['email']).to eq "#{user.id}@forgotten.com"
      end

      it 'removes the future_learn_organisation_memberships' do
        expect(JSON.parse(response.body)['future_learn_organisation_memberships']).to eq nil
      end

      it 'scrubs the credentials' do
        updated_user = User.find(user.id)
        expect(updated_user.stem_credentials_expires_at).to be_within(10.seconds).of(DateTime.now)
      end

      it 'scrubs the exposed parameters' do
        params_to_skip = %w[email future_learn_organisation_memberships created_at updated_at enrolments achievements]
        parsed_response = JSON.parse(response.body)
        parsed_response.each do |key, value|
          next if params_to_skip.include? key

          expect(value).to eq(user.id)
        end
      end

      it 'does not break the relationships' do
        expect(JSON.parse(response.body)['achievements'].count).to eq 1
        expect(JSON.parse(response.body)['enrolments'].count).to eq 1
      end

      it 'flags the user as forgotten' do
        updated_user = User.find(user.id)
        expect(updated_user.forgotten).to be true
      end
    end
  end
end
