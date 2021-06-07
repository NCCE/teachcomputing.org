require 'rails_helper'

RSpec.describe BorderedCardsComponent, type: :component do
  let(:test_data) { AboutPage.support_cards }

  context 'without an image' do
    before do
      render_inline(described_class.new(test_data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.support-cards')
    end

    it 'renders the expected number of cards' do
      expect(rendered_component).to have_css('.bordered-card', count: 4)
    end

    it 'sets the expected properties' do
      pending('Add test that checks custom properties are set correctly')
      expect(rendered_component).to have_css('--cards-per-row: 3;')
    end

    it 'does not render an image' do
      expect(rendered_component).not_to have_css('bordered-card__image-wrapper')
    end

    it 'has the expected titles' do
      expect(rendered_component).to have_css('.supporting-partners-card', text: 'Supporting partners')
      expect(rendered_component).to have_css('.involvement-card', text: 'Get involved')
      expect(rendered_component).to have_css('.contributing-partners-card', text: 'Contributing partners')
      expect(rendered_component).to have_css('.governors-card', text: 'School governors')
    end

    it 'has the expected body' do
      expect(rendered_component).to have_css('.govuk-body',
                                             text: 'Help us continue to remove barriers for teachers in state-funded education in England to access essential CPD.')
    end

    it 'has the expected link' do
      expect(rendered_component).to have_link('Support us', href: '/supporting-partners')
    end
  end

  context 'with an image' do
    before do
      test_data[:cards][0][:image_url] = 'media/images/logos/isaac-logo-with-bg.svg'
      render_inline(described_class.new(test_data))
    end

    it 'renders an image' do
      expect(rendered_component).to have_css('.bordered-card__image-wrapper')
    end
  end
end
