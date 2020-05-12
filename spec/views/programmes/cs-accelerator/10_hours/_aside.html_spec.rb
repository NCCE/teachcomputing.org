require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/10_hours/_aside', type: :view) do
  it 'has the correct title' do
    render
    expect(rendered).to have_css('.ncce-aside__title', text: 'Support')
  end

  it 'renders a link to contact support' do
    render
    expect(rendered).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
  end

  it 'renders a link to FAQs' do
    render
    expect(rendered).to have_link('Frequently Asked Questions', href: '/faq/courses')
  end

  it 'renders a link to  the handbook' do
    render
    expect(rendered).to have_link('Download our Revision Handbook', href: 'https://static.teachcomputing.org/CS_Accelerator_handbook.pdf')
  end
end
