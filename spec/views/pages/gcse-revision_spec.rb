require 'rails_helper'

RSpec.describe('pages/gcse-revision', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'GCSE revision')
  end

  it 'has aside secton' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has six lists' do
    expect(rendered).to have_css('.govuk-list', count: 6)
  end

  it 'has three headings' do
    expect(rendered).to have_css('.govuk-heading-m', count: 4)
  end

end
