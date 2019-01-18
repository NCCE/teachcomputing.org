require 'rails_helper'

RSpec.describe('pages/home/_stay-updated', type: :view) do
  before do
    render
  end

  it('renders the correct number of cards') do
    expect(rendered).to(have_css('.ncce-stay-updated__panel', count: 3))
  end

end
