require 'rails_helper'

RSpec.describe NonBorderedCardComponent, type: :component do
  let(:test_data) { AboutPage.programme_cards[:cards][0] }

  context 'without an image' do
    before do
      render_inline(described_class.new(test_data))
    end

    it 'does not render an image' do
      expect(rendered_component).not_to have_css('non-bordered-card-component__image-wrapper')
    end

    it 'has the expected title' do
      expect(rendered_component).to have_css(' .govuk-heading-m', text: 'Primary teachers')
    end

    it 'has the expected body' do
      expect(rendered_component).to have_css('.govuk-body',
                                             text: 'Resources and training for primary teachers.')
    end

    it 'has the expected link' do
      expect(rendered_component).to have_link('Primary teachers toolkit', href: '/primary-teachers')
    end
  end

  context 'with an image' do
    before do
      test_data[:image_url] = 'media/images/logos/isaac-logo-with-bg.svg'
      render_inline(described_class.new(test_data))
    end

    it 'renders an image' do
      expect(rendered_component).to have_css('.non-bordered-card-component__image-wrapper')
    end
  end
end
