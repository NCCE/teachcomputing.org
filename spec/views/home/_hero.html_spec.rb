require 'rails_helper'

RSpec.describe('home/_hero', type: :view) do
  before do
    render
  end

  it 'button to find out more about NCCE' do
    expect(rendered).to have_css('.c-hero--button', text: 'About the NCCE')
  end
end
