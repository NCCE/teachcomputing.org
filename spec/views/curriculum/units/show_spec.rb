require 'rails_helper'

RSpec.describe('curriculum/units/show', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Computing Systems and Networks – Technology Around Us')
  end

  it 'has a unit label' do
    expect(rendered).to have_css('.curriculum__label', text: 'Unit')
  end

  it 'links to feedback form' do
    expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
  end

  it 'links to rating' do
    expect(rendered).to have_css('.curriculum__rating--text', text: 'Did you find this unit useful?')
  end
end
