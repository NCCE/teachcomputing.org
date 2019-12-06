require 'rails_helper'

RSpec.describe('pages/primary-teachers', type: :view) do
  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'Inspiration and support for teaching primary computing')
  end

  it 'has embedded video' do
    render
    expect(rendered).to have_css('video', count: 1)
  end

  it 'has resources section' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'Access our free teaching resources')
  end

  it 'has a link to Primary cert' do
    expect(rendered).to have_link('Teach primary computing', href: primary_path)
  end
end
