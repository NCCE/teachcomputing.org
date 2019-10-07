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
end
