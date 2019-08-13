require 'rails_helper'

RSpec.describe('pages/home/_offering', type: :view) do
  before do
    render
  end

  it('contains the offering text') do
    expect(rendered).to have_css('.ncce-offering__aside-text', text: 'You have the power to transform lives, so we want to help you to change computing education across England.')
  end
end
