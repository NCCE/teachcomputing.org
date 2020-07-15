require 'rails_helper'

RSpec.describe('curriculum/units_lessons', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Lessons')
  end

  it 'has list of lessons' do
    expect(rendered).to have_css('.govuk-list', count: 1)
  end

end
