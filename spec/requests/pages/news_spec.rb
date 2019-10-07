require 'rails_helper'

RSpec.describe PagesController do
  describe '#news' do
    context 'index' do
      before do
        get '/news'
      end

      it 'has a status code of 301 - redirected' do
        expect(response).to have_http_status(:moved_permanently)
      end

      it 'renders the index' do
        expect(response).to redirect_to('https://blog.teachcomputing.org/tag/news')
      end
    end
  end
end
