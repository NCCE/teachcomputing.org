require 'rails_helper'

RSpec.describe CmsController do
  describe 'GET #cms_post' do
    context 'with a valid page' do
      before do
        stub_cms_post
        get '/blog/funding'
      end

      it 'assigns @article' do
        expect(assigns(:article)).to be_a(Object)
      end

      it '@article has a title' do
        expect(assigns(:article)['title']).to eq('Test')
      end

      it 'renders the template' do
        expect(response).to render_template('article')
      end

      it 'has the expected class' do
        expect(assigns(:style_slug)).to eq('funding')
      end
    end

    context 'with a missing page' do
      before do
        stub_missing_cms_post
      end

      it 'raises an error' do
        expect { get '/blog/eggs' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
