require 'rails_helper'

RSpec.describe TickListComponent, type: :component do
  let(:test_data) do
    {
      class_name: 'quality-framework-tick-list',
      title: 'The Computing Quality Framework',
      text: 'The Computing Quality Framework helps you and your leadership ' \
            'team assess your computing offer. Use our guided journey to:',
      bullets: [
        'Identify strengths and weaknesses in your computing curriculum',
        'Gain feedback and suggested actions, including relevant resources',
        'Track progress towards achieving our accredited Computing Quality Mark'
      ],
      button: {
        button_title: 'Register for the Computing Quality Framework',
        button_url: '/register'
      }
    }
  end

  context 'with no date' do
    before do
      render_inline(described_class.new(**test_data))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css(".#{test_data[:class_name]}")
    end

    it 'renders a title' do
      expect(rendered_component).to have_css(
        '.tick-list-component__title',
        text: test_data[:title]
      )
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css(
        '.tick-list-component__text',
        text: test_data[:text]
      )
    end

    it 'renders a button' do
      expect(rendered_component).to have_link(
        test_data[:button][:button_title],
        href: test_data[:button][:button_url]
      )
    end

    it 'renders a list with the expected number of items' do
      expect(rendered_component).to have_css(
        '.tick-list-component__list li',
        count: test_data[:bullets].count
      )
    end
  end
end
