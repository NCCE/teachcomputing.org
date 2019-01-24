require 'rails_helper'

RSpec.describe('pages/privacy', type: :view) do
  before do
    render
  end

  it 'has a mailto stem link' do
    expect(rendered).to have_link('datasecurity@stem.org.uk', href: 'mailto:datasecurity@stem.org.uk', count: 3)
  end

  it 'has a mailto ncce link' do
    expect(rendered).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
  end

  it 'has the STEM text link' do
    expect(rendered).to have_link('www.stem.org.uk', href: /www\.stem\.org\.uk/)
  end

  it 'has the RPi text link' do
    expect(rendered).to have_link('www.raspberrypi.org', href: /www\.raspberrypi\.org/)
  end

  it 'has the BCS text link' do
    expect(rendered).to have_link('www.bcs.org', href: /www\.bcs\.org/)
  end

  it 'has the cookies link' do
    expect(rendered).to have_link('how to manage cookies', href: /ico\.org\.uk/)
  end

  it 'has the google opt-out link' do
    expect(rendered).to have_link('opt out of Google Analytics cookies', href: /tools\.google\.com/)
  end
end
