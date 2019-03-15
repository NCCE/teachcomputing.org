require 'rails_helper'

RSpec.describe('pages/accelerator', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'The Computer Science Accelerator Programme')
  end

  it 'has a bursary link' do
    expect(rendered).to have_link('Read about our bursaries', href: '/bursary')
  end

  it 'has a link to the courses' do
    expect(rendered).to have_link('Browse available courses', href: '/courses')
  end

end
