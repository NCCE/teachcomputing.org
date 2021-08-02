require 'rails_helper'

RSpec.describe ImageLinkCardComponent, type: :component do
  let(:card) do
    {
      title_locale: 'test.image_link_card.title',
      link_url: 'https://www.example.com',
      image_path: 'media/images/test/example.svg',
      img_alt_locale: 'test.image_link_card.img_alt',
      text_locale: 'test.image_link_card.text_html'
    }
  end

  it 'renders title from locale passed in' do
    render_inline(described_class.new(image_link_card: card))
    expect(rendered_component).to have_text(I18n.t('test.image_link_card.title'))
  end

  it 'renders text from locale passed in' do
    render_inline(described_class.new(image_link_card: card))
    expect(rendered_component).to include(I18n.t('test.image_link_card.text_html'))
  end

  it 'includes image alt from locale passed in' do
    render_inline(described_class.new(image_link_card: card))
    expect(rendered_component).to include(I18n.t('test.image_link_card.img_alt'))
  end

  it 'includes link to correct url' do
    render_inline(described_class.new(image_link_card: card))
    expect(rendered_component).to have_link('Test card title', href: 'https://www.example.com')
  end
end
