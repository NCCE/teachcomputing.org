require 'rails_helper'

RSpec.describe ReportCardComponent, type: :component do
  context 'with no date' do
    before do
      render_inline(described_class.new(AboutPage.report_card))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.impact-and-evaluation-report-card')
    end

    it 'renders a title' do
      expect(rendered_component).to have_css('.report-card-component__title', text: 'Impact and evaluation')
    end

    it 'does not render a date' do
      expect(rendered_component).not_to have_css('.report-card-component__date')
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css('.report-card-component__text',
                                             text: 'View our report on how we are improving the quality of teaching computing in schools.')
    end

    it 'renders a button' do
      expect(rendered_component).to have_link('See our latest report', href: 'https://www.stem.org.uk/sites/default/files/pages/downloads/NCCE_Impact_Report_Final.pdf')
    end

    it 'renders a list with the expected number of items' do
      expect(rendered_component).to have_css('.report-card-component__list li', count: 3)
    end
  end

  context 'with a date' do
    before do
      test_data = AboutPage.report_card
      test_data[:date] = 'May 2021'
      render_inline(described_class.new(test_data))
    end

    it 'renders a date' do
      expect(rendered_component).to have_css('.report-card-component__date', text: 'May 2021')
    end
  end
end
