require 'rails_helper'

RSpec.describe Admin::ProgrammesController do

  let(:programme) { create(:programme) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return('user@example.com')
  end

  describe 'GET #index' do

    before do
      get admin_programmes_path
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

  end

  describe 'GET #show' do

    before do
      get admin_programme_path(programme)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

  end

end
