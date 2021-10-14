require 'rails_helper'

RSpec.describe FileCardComponent, type: :component do
  let(:card) do
    {
      title: 'Example file 1',
      file_info: {
        path: 'https://www.example.com/',
        type: 'JPG',
        size: '1 Megabyte',
        updated: '14 Oct 2021'
      }
    }
  end

  before do
    render_inline(described_class.new(file_card: card))
  end

  it 'renders with the expected link' do
    expect(rendered_component).to have_link('Example file 1', href: 'https://www.example.com/')
  end

  it 'renders with the expected file type' do
    expect(rendered_component).to have_text('JPG')
  end

  it 'renders with the expected file size' do
    expect(rendered_component).to have_text('1 Megabyte')
  end

  it 'renders with the expected updated date' do
    expect(rendered_component).to have_text('14 Oct 2021')
  end
end
