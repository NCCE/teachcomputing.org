require 'rails_helper'

RSpec.describe TickListComponent, type: :component do
  let(:tick_list) do
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
      render_inline(described_class.new(tick_list:))
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css(".#{tick_list[:class_name]}")
    end

    it 'renders a title' do
      expect(rendered_component).to have_css(
        '.tick-list-component__title',
        text: tick_list[:title]
      )
    end

    it 'renders the body text' do
      expect(rendered_component).to have_css(
        '.tick-list-component__text',
        text: tick_list[:text]
      )
    end

    it 'renders a button' do
      expect(rendered_component).to have_link(
        tick_list[:button][:button_title],
        href: tick_list[:button][:button_url]
      )
    end

    it 'renders a list with the expected number of items' do
      expect(rendered_component).to have_css(
        '.tick-list-component__list li',
        count: tick_list[:bullets].count
      )
    end
  end
end
