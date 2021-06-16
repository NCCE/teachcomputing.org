require 'rails_helper'

RSpec.describe HeroImageComponent, type: :component do
  before do
    render_inline(described_class.new(AboutPage.hero))
  end

  it 'adds the wrapper class' do
    expect(rendered_component).to have_css('.dixie-bg')
  end

  it 'renders the title' do
    expect(rendered_component).to have_css('.hero-image-component__title', text: 'About us')
  end

  it 'renders the body text' do
    expect(rendered_component).to have_css('.hero-image-component__text',
                                           text: 'Our vision is for every child in England to have a world-leading computing education.')
  end

  it 'renders an image' do
    expect(rendered_component).to have_css('.hero-image-component__image')
  end
end
