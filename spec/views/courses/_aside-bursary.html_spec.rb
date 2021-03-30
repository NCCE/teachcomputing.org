require 'rails_helper'

RSpec.describe('courses/_aside-bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Bursary support')
  end

  it 'renders a link' do
    expect(rendered).to have_link('Bursary information', href: '/bursary')
  end
end
