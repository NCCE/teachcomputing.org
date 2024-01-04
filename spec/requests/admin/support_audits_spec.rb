require 'rails_helper'

RSpec.describe 'Admin::SupportAuditsController' do
  let(:support_audit) { create(:support_audit) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return('user@example.com')
  end

  describe 'GET #index' do

    before do
      get admin_support_audits_path
    end

    it 'should render correct template' do
      expect(response).to render_template('index')
    end

  end

  describe 'GET #show' do

    before do
      get admin_support_audit_path(support_audit)
    end

    it 'should render correct template' do
      expect(response).to render_template('show')
    end

  end

  describe 'PUT #update' do

    before do
      put admin_support_audit_path(support_audit, params: {
        support_audit: { name: 'test' }
      })
    end

    it 'should redirect to the show page' do
      expect(response).to redirect_to(admin_users_path)
    end

  end

end
