require 'rails_helper'

RSpec.describe('curriculum/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'ANNOUNCEMENT')
  end

  it 'has some words' do
    expect(rendered).to have_text('Tried one of our resources?')
  end
end
