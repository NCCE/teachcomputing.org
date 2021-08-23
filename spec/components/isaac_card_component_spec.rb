require 'rails_helper'

RSpec.describe IsaacCardComponent, type: :component do
  before do
    render_inline(described_class.new)
  end

  it 'has the expected bg' do
    expect(rendered_component).to have_css('.isaac-bg')
  end

  it 'renders the isaac logo' do
    expect(rendered_component).to have_css("img[src*='isaac-logo']")
  end

  it 'renders the body text' do
    expect(rendered_component).to have_css('.isaac-card-component__description', text: 'Isaac Computer Science is our free online learning programme for')
  end

  it 'renders a link' do
    expect(rendered_component).to have_link('Discover Isaac Computer Science', href: '/a-level-computer-science')
  end
end
