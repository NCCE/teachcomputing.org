require 'rails_helper'

RSpec.describe DocumentCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: 'evaluation-cards',
      show_border: true,
      cards: [
        {
          class_name: 'impact-graduates-card',
          title_link: {
            title: 'Computer Science Accelerator Graduates Evaluation (cohort 2)',
            url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort_2_Evaluation.pdf'
          },
          date: 'Published July 2021',
          body: {
            text: 'Read the experiences of our second cohort of graduates and the impact of completing the Computer Science Accelerator on them, their students and colleagues.'
          }
        },
        {
          class_name: 'impact-graduates-card',
          title_link: {
            title: 'Computer Science Accelerator Graduates Evaluation (cohort 1)',
            url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf'
          },
          date: 'Published October 2020',
          body: {
            text: 'Reviews feedback from the first graduates of the Computer Science Accelerator programme, covering programme quality, value, impact, and overall experience.'
          }
        }
      ]
    }
  end

  context 'with no date' do
    before do
      test_data[:cards][0][:date] = nil
      render_inline(described_class.new(**test_data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.evaluation-cards')
    end

    it 'renders the expected number of cards' do
      expect(rendered_component).to have_css('.document-card', count: 2)
    end

    it 'sets show-border data attribute' do
      expect(rendered_component).to have_css(".evaluation-cards[data-show-border='true']")
    end

    it 'sets the expected properties' do
      pending('Add test that checks custom properties are set correctly')
      expect(rendered_component).to have_css('--cards-per-row: 3;')
    end

    it 'adds the card wrapper class' do
      expect(rendered_component).to have_css('.impact-graduates-card')
    end

    it 'renders a title' do
      expect(rendered_component).to have_link(
        'Computer Science Accelerator Graduates Evaluation (cohort 1)',
        href: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf'
      )
    end

    it 'does not render any dates' do
      expect(rendered_component).to have_css('.document-card__date')
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css(
        '.document-card__text',
        text: 'Reviews feedback from the first graduates of the Computer Science Accelerator'
      )
    end
  end

  context 'with a date' do
    before do
      render_inline(described_class.new(**test_data))
    end

    it 'renders a date' do
      expect(rendered_component).to have_css('.document-card__date', text: 'Published October 2020')
    end
  end
end
