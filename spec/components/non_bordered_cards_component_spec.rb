require 'rails_helper'

RSpec.describe NonBorderedCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: 'programme-cards',
      cards: [
        {
          class_name: 'bordered-card--primary-cert',
          title: I18n.t('pages.about.primary_card.title'),
          text: I18n.t('pages.about.primary_card.text'),
          link: {
            link_title: I18n.t('pages.about.primary_card.link_title'),
            link_url: '/primary-teachers'
          }
        },
        {
          class_name: 'bordered-card--secondary-cert',
          title: I18n.t('pages.about.secondary_card.title'),
          text: I18n.t('pages.about.secondary_card.text'),
          link: {
            link_title: I18n.t('pages.about.secondary_card.link_title'),
            link_url: '/secondary-teachers'
          }
        }
      ]
    }
  end

  context 'without an image' do
    before do
      render_inline(described_class.new(**test_data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.programme-cards')
    end

    it 'renders the expected number of cards' do
      expect(rendered_component).to have_css('.non-bordered-card', count: 2)
    end

    it 'sets the expected properties' do
      pending('Add test that checks custom properties are set correctly')
      expect(rendered_component).to have_css('--cards-per-row: 3;')
    end

    it 'does not render an image' do
      expect(rendered_component).not_to have_css('non-bordered-card__image-wrapper')
    end

    it 'has the expected titles' do
      expect(rendered_component).to have_css('.govuk-heading-m', text: 'Primary teachers')
    end

    it 'has the expected custom classes' do
      expect(rendered_component).to have_css('.bordered-card--primary-cert')
      expect(rendered_component).to have_css('.bordered-card--secondary-cert')
    end

    it 'has the expected text' do
      expect(rendered_component).to have_css('.non-bordered-card__text',
                                             text: 'Resources and training for primary teachers.')
    end

    it 'has the expected link' do
      expect(rendered_component).to have_link('Primary teachers toolkit', href: '/primary-teachers')
    end
  end

  context 'with an image' do
    before do
      test_data[:cards][0][:image_url] = 'media/images/logos/isaac-logo-with-bg.svg'
      render_inline(described_class.new(**test_data))
    end

    it 'renders an image' do
      expect(rendered_component).to have_css('.non-bordered-card__image-wrapper')
    end
  end

  context 'without text' do
    before do
      test_data[:cards][0][:text] = nil
      test_data[:cards][1][:text] = nil
      render_inline(described_class.new(**test_data))
    end

    it 'does have the expected text' do
      expect(rendered_component).not_to have_css('.non-bordered-card__text')
    end
  end
end
