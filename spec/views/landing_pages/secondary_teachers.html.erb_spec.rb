require 'rails_helper'

RSpec.describe('landing_pages/secondary_teachers', type: :view) do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  before do
    @cs_accelerator = cs_accelerator
    @secondary_certificate = secondary_certificate
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'The essential toolkit for secondary computing teachers')
  end

  it 'has embedded video' do
    expect(rendered).to have_css('video', count: 1)
  end

  it 'renders cs accelerator card' do
    expect(rendered).to have_css('.card__heading', text: 'GCSE computer science subject knowledge')
  end

  it 'renders the secondary certificate card' do
    expect(rendered).to have_css('.card__heading', text: 'Teach secondary computing')
  end
end
