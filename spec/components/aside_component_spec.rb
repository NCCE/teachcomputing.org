require 'rails_helper'

RSpec.describe AsideComponent, type: :component do
  it 'renders ' do
    render_inline(
      described_class.new(
        title: 'Test title',
        text: 'The body text',
        link: {
          url: 'http://example.com',
          text: 'The link text'
        }
      )
    )
    expect(rendered_component).to have_text('Test title')
    expect(rendered_component).to have_text('The body text')
    expect(rendered_component).to have_link('The link text', href: 'http://example.com')
  end
end
