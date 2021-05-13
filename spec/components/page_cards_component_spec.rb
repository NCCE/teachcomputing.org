require 'rails_helper'

RSpec.describe PageCardsComponent, type: :component do
  before do
    render_inline(described_class.new(AboutPage.programme_cards))
  end

  it 'adds the wrapper class' do
    expect(rendered_component).to have_css('.programme-cards')
  end

  it 'renders the expected number of cards' do
    expect(rendered_component).to have_css('.page-card-component--card', count: 2)
  end
end
