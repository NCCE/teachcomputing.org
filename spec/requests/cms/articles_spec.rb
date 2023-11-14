require 'rails_helper'

RSpec.describe CmsController do
  describe 'GET #articles' do
    context 'with a valid page' do
      before do
        stub_cms_articles
        get '/blog'
      end

      it 'renders the template' do
        expect(response).to render_template('articles')
      end
    end
  end
end
