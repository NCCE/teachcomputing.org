require 'rails_helper'

RSpec.describe('curriculum/units/_lessons', type: :view) do
  before do
    render
  end

  it 'has a paragraph' do
    expect(rendered).to have_css('.govuk-body-l', text: 'Lessons')
  end

  it 'has list of lessons' do
    expect(rendered).to have_css('.govuk-list', count: 1)
  end

end
