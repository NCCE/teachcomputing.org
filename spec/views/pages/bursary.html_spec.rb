require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Bursary entitlement')
  end

  it 'has accelerator links' do
    expect(rendered).to have_link('Computer Science Accelerator Programme', href: '/accelerator')
    expect(rendered).to have_link('Find out more about the programme', href: '/accelerator')
  end

  it 'has a offer links' do
    expect(rendered).to have_link('Find out more about our CPD', href: '/offer')
    expect(rendered).to have_link('Find out more', href: '/offer')
  end

  it 'has a contact link' do
    expect(rendered).to have_link('Contact us', href: 'mailto:info@teachcomputing.org')
  end

  it 'has a map link' do
    expect(rendered).to have_css('.ncce-link', text: 'map')
  end

end
