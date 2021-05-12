require 'rails_helper'

RSpec.describe PageCardComponent, type: :component do
  context 'without an image' do
    before do
      render_inline(described_class.new(AboutPage.programme_cards))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.programme-cards')
    end

    it 'does not render an image' do
      expect(rendered_component).not_to have_css('page-card-component--image-wrapper')
    end

    it 'renders the expected number of cards' do
      expect(rendered_component).to have_css('.page-card-component--card', count: 2)
    end

    describe 'when the first card is rendered' do
      it 'has the expected title' do
        expect(rendered_component).to have_css('.card-1 .govuk-heading-m', text: 'Primary teachers')
      end

      it 'has the expected body' do
        expect(rendered_component).to have_css('.card-1 .govuk-body',
                                               text: 'Resources and training for primary teachers.')
      end

      it 'has the expected link' do
        expect(rendered_component).to have_link('Primary teachers toolkit', href: '/primary-teachers')
      end
    end

    describe 'when the second card is rendered' do
      it 'has the expected title' do
        expect(rendered_component).to have_css('.card-2 .govuk-heading-m', text: 'Secondary teachers')
      end

      it 'has the expected body' do
        expect(rendered_component).to have_css('.card-2 .govuk-body',
                                               text: 'Everything you need to teach computing at secondary level')
      end

      it 'has the expected link' do
        expect(rendered_component).to have_link('Secondary teachers toolkit', href: '/secondary-teachers')
      end
    end
  end

  context 'with an image' do
    before do
      test_data = AboutPage.programme_cards
      test_data[:cards][0][:image_url] = 'media/images/logos/isaac-logo-with-bg.svg'
      render_inline(described_class.new(test_data))
    end

    it 'renders an image' do
      expect(rendered_component).to have_css('.page-card-component--image-wrapper')
    end
  end
end
