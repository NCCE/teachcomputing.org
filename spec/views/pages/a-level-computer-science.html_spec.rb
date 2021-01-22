require 'rails_helper'

RSpec.describe('pages/a-level-computer-science', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('', text: '')
  end

end
