require 'rails_helper'

RSpec.describe LogoCardsComponent, type: :component do
  let(:test_data) { ImpactPage.partner_resources }

  before do
    render_inline(described_class.new(test_data))
  end

  it 'adds the wrapper class' do
    expect(rendered_component).to have_css('.partner-resources')
  end

  it 'sets the expected properties' do
    pending('Add test that checks custom properties are set correctly')
    expect(rendered_component).to have_css('--cards-per-row: 3;')
  end

  it 'renders the expected number of cards' do
    expect(rendered_component).to have_css('.logo-card', count: 3)
  end

  it 'renders an image' do
    expect(rendered_component).to have_css('.logo-card__image-wrapper')
  end

  it 'has the expected link' do
    expect(rendered_component).to have_link('Impact and evaluation', href: 'https://www.stem.org.uk/impact-and-evaluation')
  end
end
