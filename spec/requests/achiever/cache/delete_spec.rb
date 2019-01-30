require 'rails_helper'

RSpec.describe Achiever::CacheController do
  let(:workflow_id) { '166D3000-7936-4DA2-BAF0-2588ADEC6435' }

  describe '#DELETE' do
    before do
      allow(Rails.cache).to receive(:delete).and_return(0)
    end

    it 'responds with a status code of 200' do
      delete achiever_cache_path(cache: { id: workflow_id })
      
      expect(response).to have_http_status(:ok)
    end
  end
end
