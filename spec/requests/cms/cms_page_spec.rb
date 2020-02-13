require 'rails_helper'

RSpec.describe CmsController do
  describe 'GET #cms_page' do
    context 'with a valid page' do
      before do
        stub_cms_page
        get '/bursary-cms'
      end

      it 'assigns @page' do
        expect(assigns(:page)).to be_a(Object)
      end

      it '@page has a title' do
        expect(assigns(:page)['title']).to eq('Test')
      end

      it 'renders the template' do
        expect(response).to render_template('cms_page')
      end
    end

    context 'with a missing page' do
      before do
        stub_missing_cms_page
      end

      it 'raises an error' do
        expect { get '/bursary-cms' }.to raise_error(NoMethodError)
      end
    end
  end
end
