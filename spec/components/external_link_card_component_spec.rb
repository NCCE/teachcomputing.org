require "rails_helper"

RSpec.describe ExternalLinkCardComponent, type: :component do

  let(:link_card) do
    {
      title: 'Testing',
      link: 'https://www.example.com'
    }
  end

  let(:link_card_missing_link) do
    {
      title: 'Missing Link',
      link: nil
    }
  end

  describe 'with no link defined' do

    before do
      render_inline(described_class.new(external_link_card: link_card_missing_link))
    end

    it 'should not show anything when link is missing' do
      expect(page).not_to have_link('Missing Link', href: '')
    end
  end

  describe 'with link defined' do
    before do
      render_inline(described_class.new(external_link_card: link_card))
    end

    it 'renders with expected link' do
      expect(page).to have_link('Testing', href: 'https://www.example.com')
    end
  end

end
