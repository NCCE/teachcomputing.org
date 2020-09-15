require 'rails_helper'

RSpec.describe Admin::UsersController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:programme) { create(:programme) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme)}
	let(:achievement) { create(:achievement, user: user, programme: programme) }
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }

  context 'token is not passed' do
    describe 'GET #show' do
      before do
        get "/admin/users/", { params: { email: user.email }, headers: nil }
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
        get "/admin/users/", { params: { email: user.email }, headers: token_headers }
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
  end
end
