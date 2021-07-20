require 'rails_helper'

RSpec.describe NoHubsComponent, type: :component do
  let(:hub) { build(:hub) }

  context 'when there are no hubs' do
    it 'does not render' do
      render_inline(described_class.new(sorted_hubs: [hub], hub_regions: []))
      expect(rendered_component).to eq('')
    end
  end

  context 'when there are hubs' do
    before do
      render_inline(described_class.new(sorted_hubs: [], hub_regions: []))
    end

    it 'shows the sad face emoji' do
      expect(rendered_component).to have_css("img[src*='sad-face']")
    end

    it 'shows the expected text' do
      expect(rendered_component).to have_text("Sorry, we couldn't find any Hubs that match your search.")
      expect(rendered_component).to have_text('Try modifying or clearing your search to see more results.')
    end

    it 'renders with a button to clear the search' do
      expect(rendered_component).to have_link('Clear your search', href: '/hubs#sorted_hubs')
    end
  end
end
