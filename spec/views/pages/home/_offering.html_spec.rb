require 'rails_helper'

RSpec.describe('pages/home/_offering', type: :view) do
  before do
    render
  end

  it('contains the offering text') do
    expect(rendered).to have_css('.card__text', text: /You have the power to transform/)
  end
end
