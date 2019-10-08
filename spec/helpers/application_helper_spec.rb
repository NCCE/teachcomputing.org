require 'rails_helper'

describe ApplicationHelper, type: :helper do

  describe('#auth_url') do
    it 'returns the correct url' do
      expect(helper.auth_url).to eq '/auth/stem'
    end
  end

  describe('#create_account_url') do
    it 'returns the correct url' do
      expect(helper.create_account_url).to match(%r{http.+/user/register\?from=NCCE})
    end
  end

  describe('#news_url') do
    it 'returns the correct url' do
      expect(helper.news_url).to eq('https://blog.teachcomputing.org/tag/news/')
    end
  end

  describe('#press_url') do
    it 'returns the correct url' do
      expect(helper.press_url).to eq('https://blog.teachcomputing.org/tag/press/')
    end
  end
end
