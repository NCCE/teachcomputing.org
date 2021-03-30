require 'rails_helper'

RSpec.describe('landing_pages/secondary_teachers', type: :view) do
  before do
    @landing_page = SecondaryLandingPage.new(current_user: nil)
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'The essential toolkit for secondary computing teachers')
  end

  it 'renders certificates' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Certificates')
  end

  it 'renders courses' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Courses')
  end

  it 'renders resources' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Resources')
  end

  it 'renders support section' do
    expect(rendered).to have_css('.govuk-heading-l', text: "We're here to help")
  end
end
