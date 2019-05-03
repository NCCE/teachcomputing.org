require 'rails_helper'

RSpec.describe('pages/cs-accelerator', type: :view) do
  before do
    render
  end

  it 'has aside section' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

end
