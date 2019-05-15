require 'rails_helper'

RSpec.describe Activities::DownloadsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }

  describe 'GET show' do
    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get activities_download_path(activity.id, file: { name: 'NCCE.Diagnostic.pdf' })
      end

      it 'creates an Achievement if one does not exist already' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement in a state of complete' do
        expect(user.achievements.where(activity_id: activity.id).first.current_state).to eq 'complete'
      end
    end

    describe 'while logged out' do
      before do
        get activities_download_path(activity.id, file: { name: 'NCCE.Diagnostic.pdf' })
      end

      it 'redirects to login' do
        expect(response).to redirect_to(login_path)
      end

      it 'creates an Achievement if one does not exist already' do
        expect(Achievement.count).to eq 0
      end
    end
  end
end
