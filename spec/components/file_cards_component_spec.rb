require 'rails_helper'

RSpec.describe FileCardsComponent, type: :component do
  let(:cards) do
    [
      {
        title: 'Example file 1',
        file_info: {
          path: 'https://www.example.com/',
          type: 'JPG',
          size: '1 Megabyte',
          updated: '14 Oct 2021'
        }
      },
      {
        title: 'Example file 2',
        file_info: {
          path: 'https://www.example.com/',
          type: 'PDF',
          size: '150 Kilobytes',
          updated: '12 Oct 2021'
        }
      }
    ]
  end

  before do
    render_inline(described_class.new(cards: cards))
  end

  it 'renders a wrapper element' do
    expect(rendered_component).to have_css('.file-cards-component', count: 1)
  end

  it 'renders an element for each card' do
    expect(rendered_component).to have_css('.file-card-component', count: 2)
  end
end
