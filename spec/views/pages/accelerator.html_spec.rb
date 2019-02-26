require 'rails_helper'

RSpec.describe('pages/accelerator', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'The Computer Science Accelerator Programme')
  end

  it 'has five subtitles' do
    expect(rendered).to have_css('.govuk-heading-s', count:5)
  end

  it 'has four lists' do
    expect(rendered).to have_css('.govuk-list--bullet', count: 4)
  end

end
