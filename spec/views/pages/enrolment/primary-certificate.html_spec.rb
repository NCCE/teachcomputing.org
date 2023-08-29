require 'rails_helper'

RSpec.describe('pages/enrolment/primary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let!(:pathways) { create_list(:pathway, 2, programme:) }

  before do
    @programme = programme
  end

  before do
    render
  end

  it 'has an opening paragraph' do
    expect(rendered).to have_text('We expect it to take around 20 hours to complete.')
  end

  it 'has a benefits section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Benefits to you')
  end

  it 'has a pathway wrapper' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'How does the programme work?')
  end

  it 'has pathway cards' do
    expect(rendered).to have_css('.bordered-card')
    expect(rendered).to have_css('.govuk-heading-m', text: pathways.first.title)
  end

  it 'has a bursary support aside' do
    expect(rendered).to have_css('.bursary-component__title', text: 'Funding')
  end

  describe 'hero section' do
    it 'has title' do
      expect(rendered).to have_css('.govuk-heading-l', text: @programme.title)
    end

    it 'has sub title' do
      expect(rendered).to have_css('.govuk-body-l', text: 'Certificate awarded by BCS, The Chartered Institute for IT')
    end

    it 'has BCS logo' do
      expect(rendered).to have_css('.text-certificate-hero__area--logo img')
    end
  end
end
