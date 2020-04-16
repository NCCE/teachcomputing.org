require 'rails_helper'

RSpec.describe('landing_pages/secondary-teachers', type: :view) do
  let(:programme) { create(:cs_accelerator) }

  before do
    @programme = programme
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'The essential toolkit for secondary computing teachers')
  end

  it 'has embedded video' do
    expect(rendered).to have_css('video', count: 1)
  end
end
