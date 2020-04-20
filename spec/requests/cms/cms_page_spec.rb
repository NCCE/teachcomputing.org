require 'rails_helper'

RSpec.describe CmsController do
  describe 'GET #cms_page' do
    context 'with a valid page' do
      before do
        stub_cms_page
        get '/cms/bursary'
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
        expect { get '/cms/bursary' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #clear_page_cache' do
    context 'with a cms page' do
      before do
        stub_cms_page
        get '/cms/bursary/refresh'
      end

      it 'assigns @page' do
        expect(response).to redirect_to('/cms/bursary')
      end
    end

    context 'with a home teaching page' do
      before do
        stub_cms_page
        get '/home-teaching/key-stage-1/refresh'
      end

      it 'assigns @page' do
        expect(response).to redirect_to('/home-teaching/key-stage-1')
      end
    end
  end
end
