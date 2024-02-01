require "rails_helper"

RSpec.describe DownloadsController, type: :request do
  describe "POST" do
    let(:user) { create(:user, email: "web@teachcomputing.org") }
    let(:uri) { "https://rubyonrails.org" }

    context "with logged in user" do
      before do
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end
      it "creates download, recording logged in user" do
        post downloads_path, params: {uri: uri}
        expect(Download.first.user_id).to eq user.id
      end

      it "creates aggregate download" do
        post downloads_path, params: {uri: uri}
        expect(AggregateDownload.first.uri).to eq uri
      end

      it "increments aggregate download" do
        post downloads_path, params: {uri: uri}
        post downloads_path, params: {uri: uri}
        expect(AggregateDownload.find_by(uri: uri).count).to eq 2
      end
    end

    it "creates download without logged in user" do
      post downloads_path, params: {uri: uri}
      expect(Download.first.user_id).to eq nil
    end

    it "redirects to uri after creation" do
      post downloads_path, params: {uri: uri}
      assert_redirected_to uri
    end
  end
end
