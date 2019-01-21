require 'rails_helper'

RSpec.describe Activities::DownloadsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }

  describe 'GET show' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      get activities_download_path(activity.id, :file => { name: 'NCCE.Diagnostic.pdf', type: 'application/pdf'})
    end

    it 'creates an Achievement if one does not exist already' do
      expect(Achievement.count).to eq 1
    end
  end
end
