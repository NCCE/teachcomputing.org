require 'rails_helper'

RSpec.describe Dynamics::WebhooksController do
  let(:json_body) { File.read('spec/support/dynamics/webhook.json') }
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }
  let(:user) { create(:user, stem_achiever_contact_no: '01df05c0-7c04-11eb-9439-0242ac130002') }

  describe '#assessment' do
    before do
      user
    end

    context 'with a valid bearer token' do
      it 'queues Achiever::FetchUsersCompletedCoursesFromAchieverJob job' do
        expect do
          post dynamics_user_webhook_path, params: JSON.parse(json_body), headers: token_headers
        end.to have_enqueued_job(Achiever::FetchUsersCompletedCoursesFromAchieverJob)
      end

      it 'returns 200 response' do
        post dynamics_user_webhook_path, params: JSON.parse(json_body), headers: token_headers
        expect(response.status).to eq 200
      end
    end

    context 'with an invalid bearer token' do
      it 'raises an error' do
        post dynamics_user_webhook_path, params: JSON.parse(json_body), headers: token_headers
        expect(response.status).to eq 401
      end
    end
  end
end
