require 'rails_helper'

RSpec.describe('curriculum/key_stages/index', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.curriculum__title', text: 'Choose resources by key stage')
  end

  it 'has a paragraph' do
    expect(rendered).to have_css('.govuk-body-l', count: 1)
  end

end
