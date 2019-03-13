require 'rails_helper'

RSpec.describe Admin::ImportsController do
  let(:activities) { create_list(:activity, 5, :future_learn) }

  describe 'GET #index' do
    before do
      activities
      get admin_imports_path
    end

    it 'assigns activities instance variable' do
      expect(assigns(:activities)).to eq activities
    end
  end
end
