require 'rails_helper'

RSpec.describe('pages/certification', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Certification')
  end

  it 'has a contact link' do
    expect(rendered).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
  end

  it 'has a login link' do
    expect(rendered).to have_link('Log in to browse available CPD courses from your dashboard', href: '/login')
  end

  it 'has a create account link' do
    expect(rendered).to have_link('Create an account', href: '/login')
  end

end
