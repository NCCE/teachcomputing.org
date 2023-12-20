require 'rails_helper'

RSpec.describe SearchablePages::SitePage, type: :model do
  describe '#url' do
    it 'should return the url json property' do
      page = create(:searchable_pages_site_page, url: '/asdf')
      expect(page.url).to eq '/asdf'
    end
  end
end
