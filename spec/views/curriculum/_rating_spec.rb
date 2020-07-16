require 'rails_helper'

RSpec.describe('curriculum/_rating', type: :view) do
  before do
    render
  end

  it 'has a rating text' do
    expect(rendered).to have_css('.curriculum__rating--text', text: 'How would you rate this lesson?')
  end

  it 'has two thumbs' do
    expect(rendered).to have_css('.curriculum__rating--thumb', count: 2)
  end

end
