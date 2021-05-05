require 'rails_helper'

RSpec.describe ReportCardComponent, type: :component do
  context 'with no date' do
    before do
      render_inline(described_class.new(report_card_stub))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.report-card-example-component')
    end

    it 'renders a title' do
      expect(rendered_component).to have_css('.report-card-component__title', text: 'Report Card Component')
    end

    it 'does not render a date' do
      expect(rendered_component).not_to have_css('.report-card-component__date')
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css('.report-card-component__text', text: 'This is an example')
    end

    it 'renders a button' do
      expect(rendered_component).to have_link('Example button', href: '/')
    end

    it 'renders a list with the expected number of items' do
      expect(rendered_component).to have_css('.report-card-component__list li', count: 3)
    end
  end

  context 'with a date' do
    before do
      render_inline(described_class.new(report_card_stub('May 2021')))
    end

    it 'renders a date' do
      expect(rendered_component).to have_css('.report-card-component__date', text: 'May 2021')
    end
  end
end
