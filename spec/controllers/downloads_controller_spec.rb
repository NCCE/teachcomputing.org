require 'rails_helper'

RSpec.describe DownloadsController, type: :controller do
  describe 'POST' do
    let(:user) { create(:user, email: 'web@raspberrypi.org') }
    let(:uri) { 'https://rubyonrails.org' }

    it 'creates download, recording logged in user' do
      allow(controller).to receive(:current_user) { user }
      post :create, params: { uri: uri }
      expect(Download.first.user_id).to eq user.id
    end

    it 'creates aggregate download' do
      allow(controller).to receive(:current_user) { user }
      post :create, params: { uri: uri }
      expect(AggregateDownload.first.uri).to eq uri
    end

    it 'increments aggregate download' do
      allow(controller).to receive(:current_user) { user }
      post :create, params: { uri: uri }
      post :create, params: { uri: uri }
      expect(AggregateDownload.find_by(uri: uri).count).to eq 2
    end

    it 'creates download without logged in user' do
      post :create, params: { uri: uri }
      expect(Download.first.user_id).to eq nil
    end

    it 'redirects to uri after creation' do
      post :create, params: { uri: uri }
      assert_redirected_to uri
    end
  end
end
