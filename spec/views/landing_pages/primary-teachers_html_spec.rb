require 'rails_helper'

RSpec.describe('landing_pages/primary-teachers', type: :view) do
  let(:programme) { create(:primary_certificate ) }

  before do
    @programme = programme
    render
  end


  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Inspiration and support for teaching primary computing')
  end

  it 'has embedded video' do
    expect(rendered).to have_css('video', count: 1)
  end

  it 'has resources section' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Access our free teaching resources')
  end

end
