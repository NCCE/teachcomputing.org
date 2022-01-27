require 'rails_helper'

RSpec.describe('pages/gcse-revision', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Isaac Computer Science')
  end

  it 'has aside secton' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has five lists' do
    expect(rendered).to have_css('.govuk-list', count: 5)
  end

  it 'has three headings' do
    expect(rendered).to have_css('.govuk-heading-m', count: 4)
  end

end
