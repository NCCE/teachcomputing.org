require 'rails_helper'

RSpec.describe PagesController do
  describe '#press' do
    context 'index' do
      before do
        get '/press'
      end

      it 'has a status code of 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index' do
        expect(response).to render_template('press/index')
      end
    end

    context 'simon-peyton-jones' do
      before do
        get '/press/simon-peyton-jones-chair-ncce'
      end

      it 'has a status code of 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the view' do
        expect(response).to render_template('press/posts/simon-peyton-jones-chair-ncce')
      end
    end
  end
end
