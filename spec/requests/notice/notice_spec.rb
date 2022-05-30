require 'rails_helper'

RSpec.describe CmsController do
  describe 'GET #cms_page' do
    context 'with a valid page' do
      before do
        stub_cms_page
        get '/bursary'
      end

      it 'renders the notice' do
        expect(response).to have_text('Our bursary funding for schools and colleges')
      end
    end

    context 'with a different page' do
      before do
        get '/impact-and-evaluation'
      end

      it 'does not render the notice' do
        expect(response).not_to have_text('Our bursary funding for schools and colleges')
      end
    end
  end
end
