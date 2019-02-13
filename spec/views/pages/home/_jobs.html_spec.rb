require 'rails_helper'

RSpec.describe('pages/home/_jobs', type: :view) do
  before do
    render
  end

  it('has two titles') do
    expect(rendered).to(have_css('.govuk-heading-m', count: 2))
  end

  it('renders the correct number of links') do
    expect(rendered).to(have_css('.ncce-link', count: 3))
  end

  it('has hub link') do
    expect(rendered).to(have_link('Find out about becoming a computing hub', href: '/hub'))
  end
end
