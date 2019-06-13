require 'rails_helper'

RSpec.describe Admin::ImportsController do
  describe 'GET #new' do
    context 'when cloudflare cookie is set' do
      before do
        allow_any_instance_of(Admin::ImportsController).to receive(:set_admin).and_return('user@example.com')
        get new_admin_import_path
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when cloudflare cookie is not set' do
      before do
        get new_admin_import_path
      end

      it 'redirects the user to the index path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
