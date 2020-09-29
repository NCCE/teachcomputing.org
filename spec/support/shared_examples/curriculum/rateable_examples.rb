require 'spec_helper'

RSpec.shared_examples_for 'rateable' do |path, comment_path, context, id, rating_id|
  let(:vcr_id_base) { "curriculum/ratings" }
  let(:user) { create(:user, stem_achiever_contact_no: 'achieverid') }

  before(:each) do
    VCR.turn_on!
  end

  after(:each) do
    VCR.turn_off!
  end

  fdescribe 'GET #rate' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it 'errors for an invalid polarity' do
      expect { get send(path, polarity: :bad, id: :an_id, user_id: user.id) }
        .to raise_error(ArgumentError, 'Unexpected polarity: bad')
    end

    it 'adds a rating and returns the id' do
      VCR.use_cassette("#{vcr_id_base}/#{path}/200", :record => :new_episodes) do
        get send(path, polarity: :negative, id: id, user_id: '94c52a7c-5001-45e3-82bd-949a882f5fb6')
        body = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(body.origin).to eq('rate')
        expect(body.rating_id).to eq(rating_id)
      end
    end

    it 'creates cookies with the expected ids' do
      stub_a_valid_request()

      get send(path, polarity: :negative, id: :an_id, user_id: user.id)
      get send(path, polarity: :negative, id: :another_id, user_id: user.id)

      cookie_jar = ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
      expect(cookie_jar.encrypted[:ratings]).to eq(%i[an_id another_id].to_json)
    end

    it 'prevents re-rating' do
      stub_a_valid_request()

      get send(path, polarity: :negative, id: :an_id, user_id: user.id) # First request
      get send(path, polarity: :negative, id: :an_id, user_id: user.id) # Second request
      body = JSON.parse(response.body)
      expect(response).to have_http_status(:conflict)
      expect(body['data']).to eq(nil)
    end
  end

  fdescribe 'GET #comment' do
    it 'adds a comment to a rating' do
      VCR.use_cassette("#{vcr_id_base}/#{comment_path}/200", :record => :new_episodes) do
        post send(comment_path, rating_id: rating_id, comment: 'This is a test')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
