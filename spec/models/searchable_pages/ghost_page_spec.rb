require 'rails_helper'

RSpec.describe SearchablePages::GhostPage, type: :model do
  describe '#url' do
    it 'should return a cms_page_path' do
      page = create(:searchable_pages_ghost_page)
      expect(page.url).to eq Rails.application.routes.url_helpers.cms_page_path(page.slug)
    end
  end
end
