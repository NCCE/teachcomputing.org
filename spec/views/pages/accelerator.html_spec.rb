require 'rails_helper'

RSpec.describe('pages/accelerator', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'The Computer Science Accelerator Programme')
  end

  it 'has a bursary link' do
    render
    expect(rendered).to have_link('Read about our bursaries', href: '/bursary')
  end


  it 'has a link to the courses' do
    expect(rendered).to have_text('Browse available courses', href: '/courses')
  end


end
