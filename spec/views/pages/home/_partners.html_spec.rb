require 'rails_helper'

RSpec.describe('pages/home/_partners', type: :view) do
  before do
    render
  end

  it('renders the correct number of logos') do
    expect(rendered).to(have_css('.ncce-partners__link', count: 3))
  end

  it 'has the STEM text link' do
    expect(rendered).to have_link('STEM Learning', href: /stem\.org\.uk/)
  end

  it 'has the RPi text link' do
    expect(rendered).to have_link('Raspberry Pi Foundation', href: /raspberrypi\.org/)
  end

  it 'has the BCS text link' do
    expect(rendered).to have_link('BCS, The Chartered Institute for IT', href: /bcs\.org/)
  end
end
