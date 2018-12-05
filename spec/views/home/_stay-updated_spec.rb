require 'rails_helper'

RSpec.describe('home/_stay-updated', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-stay-updated', text: 'Stay up to date with the NCCE')
  end

  it('renders the correct number of cards') do
    expect(rendered).to(have_css('.ncce-stay-updated__panel', count: 3))
  end

end
