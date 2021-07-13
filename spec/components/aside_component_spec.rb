require 'rails_helper'

RSpec.describe AsideComponent, type: :component do
  it 'renders ' do
    render_inline(described_class.new(
                    title: 'Test title',
                    text: 'The body text',
                    link_url: 'http://example.com',
                    link_text: 'The link text'
                  ))
    expect(rendered_component).to have_text('Test title')
    expect(rendered_component).to have_text('The body text')
    expect(rendered_component).to have_link('The link text', href: 'http://example.com')
    expect(rendered_component).to have_link('The link text', href: 'http://example.com')
  end
end
