require 'rails_helper'

RSpec.describe('pages/home/_jobs', type: :view) do
  before do
    render
  end

  it('renders the correct number of links') do
    expect(rendered).to(have_css('.govuk-link', count: 3))
  end

end
