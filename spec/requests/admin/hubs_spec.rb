require 'rails_helper'

RSpec.describe 'Admin::HubsController' do
  let(:hub) { create(:hub) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return('user@example.com')
  end

  describe 'GET #index' do

    before do
      get admin_hubs_path
    end

    it 'should render correct template' do
      expect(response).to render_template('index')
    end

  end

  describe 'GET #show' do

    before do
      get admin_hub_path(hub)
    end

    it 'should render correct template' do
      expect(response).to render_template('show')
    end

  end

  describe 'PUT #update' do

    before do
      put admin_hub_path(hub, params: {
        hub: { name: 'test' }
      })
    end

    it 'should redirect to the show page' do
      expect(response).to redirect_to(admin_hub_path(hub))
    end

  end

end
