require "rails_helper"

RSpec.describe BursaryComponent, type: :component do
  it 'has a title' do
    render_inline(described_class.new())
    expect(rendered_component).to have_css('.bursary-component__title', text: 'Bursary support')
  end

  it 'renders a link' do
    render_inline(described_class.new())
    expect(rendered_component).to have_link('Bursary information', href: '/bursary')
  end

  it 'adds data attributes when passed' do
    render_inline(described_class.new(tracking_event_category: 'category', tracking_event_label: 'label'))
    expect(rendered_component).to have_selector("a[href='/bursary'][data-event-category='category']")
    expect(rendered_component).to have_selector("a[href='/bursary'][data-event-label='label']")
    expect(rendered_component).to have_selector("a[href='/bursary'][data-event-action='click']")
  end
end
