require 'rails_helper'

RSpec.describe Admin::ImportsController do
  let(:imports) { create_list(:import, 5) }

  describe 'GET #index' do
    before do
      imports
      get admin_imports_path
    end

    it 'assigns imports instance variable' do
      expect(assigns(:imports)).to eq imports
    end
  end
end
