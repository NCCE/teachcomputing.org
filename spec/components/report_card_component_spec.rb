require 'rails_helper'

RSpec.describe ReportCardComponent, type: :component do
  context 'with no date' do
    before do
      test_data = AboutPage.report_card
      test_data[:date] = nil
      test_data[:stats_date] = nil
      render_inline(described_class.new(test_data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.impact-and-evaluation-report-card')
    end

    it 'sets show-border data attribute' do
      expect(rendered_component).to have_css(".impact-and-evaluation-report-card[data-show-border='false']")
    end

    it 'renders a title' do
      expect(rendered_component).to have_css('.report-card-component__title', text: 'Impact and evaluation')
    end

    it 'does not render any dates' do
      expect(rendered_component).not_to have_css('.report-card-component__date')
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css('.report-card-component__text',
                                             text: 'View our latest impact and evaluation reports to find out how the NCCE is improving the quality of teaching computing in schools.')
    end

    it 'renders a button' do
      expect(rendered_component).to have_link('Impact and evaluation', href: '/impact-and-evaluation')
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

  context 'with a stats date' do
    before do
      test_data = AboutPage.report_card
      test_data[:stats_date] = 'These stats are not accurate'
      render_inline(described_class.new(test_data))
    end

    it 'renders a stats date' do
      expect(rendered_component).to have_css('.report-card-component__date',
                                             text: 'These stats are not accurate')
    end
  end
end
