require 'rails_helper'

RSpec.describe('pages/pedagogy', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Promoting effective computing pedagogy')
  end
end
