require 'rails_helper'

RSpec.describe 'Admin::PathwayActivitiesController' do
  let(:pathway_activity) { create(:pathway_activity) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return('user@example.com')
  end

  describe 'GET #index' do

    before do
      get admin_pathway_activities_path
    end

    it 'should render correct template' do
      expect(response).to render_template('index')
    end

  end

  describe 'GET #show' do

    before do
      get admin_pathway_activity_path(pathway_activity)
    end

    it 'should render correct template' do
      expect(response).to render_template('show')
    end

  end

  describe 'PUT #update' do

    before do
      put admin_pathway_activity_path(pathway_activity, params: {
        pathway_activity: { supplementary: true }
      })
    end

    it 'should redirect to the show page' do
      expect(response).to redirect_to(admin_pathway_activity_path(pathway_activity))
    end

  end

end
