require 'rails_helper'

RSpec.describe('pages/home/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-hero', text: 'Helping you teach computing')
  end

  it 'button to find out more about NCCE' do
    expect(rendered).to have_css('.ncce-button__blue', text: 'Get started!')
  end
end
