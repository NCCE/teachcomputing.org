require 'rails_helper'

RSpec.describe('home/_partners', type: :view) do
  before do
    render
  end

  it('renders the correct number of logos') do
    expect(rendered).to(have_css('.c-partners__link', count: 3))
  end

end
