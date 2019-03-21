require 'rails_helper'

RSpec.describe('pages/press/posts/bt-rolls-royce-arm-back-ncce', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'BT, Rolls-Royce and Arm back new National Centre for Computing Education')
  end

  it 'notes to editors' do
    expect(rendered).to have_css('.govuk-heading-s', text: 'Notes to editors:')
  end
end
