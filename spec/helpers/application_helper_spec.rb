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

  describe('#whitelist_redirect_url') do
    it 'allows teachcomputing url' do
      url = 'https://teachcomputing.org/courses/'
      expect(helper.whitelist_redirect_url(url)).to eq(url)
    end

    it 'allows stem url' do
      url = 'https://www.stem.org.uk/resources'
      expect(helper.whitelist_redirect_url(url)).to eq(url)
    end

    it 'allows staging url' do
      url = 'https://staging-teachcomputing.org/courses/'
      expect(helper.whitelist_redirect_url(url)).to eq(url)
    end

    it 'allows stem staging url' do
      url = 'https://www-stage.stem.org.uk/resources'
      expect(helper.whitelist_redirect_url(url)).to eq(url)
    end

    it 'allows teachcomputing review app url' do
      url = 'https://teachcomputing-staging-pr-460.herokuapp.com/courses/'
      expect(helper.whitelist_redirect_url(url)).to eq(url)
    end

    it 'does not allow urls that are not whitelisted' do
      url = 'https://3v1l-h4x0rs.com/steal-your-details'
      expect(helper.whitelist_redirect_url(url)).to be nil
    end
  end
end
