require 'rails_helper'

RSpec.describe('curriculum/_feedback', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.padded-box__title', text: 'Help us make these resources better')
  end

  it 'links to feedback form' do
    expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
  end
end
