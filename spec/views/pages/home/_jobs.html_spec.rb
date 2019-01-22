require 'rails_helper'

RSpec.describe('pages/home/_jobs', type: :view) do
  before do
    render
  end

  it('renders the correct number of links') do
    expect(rendered).to(have_css('.ncce-link__on-light', count: 3))
  end

end
