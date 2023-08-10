require 'rails_helper'

RSpec.describe('pages/enrolment/secondary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:secondary_certificate) }
  let!(:pathways) { create_list(:pathway, 5, programme:) }

  before do
    @programme = programme
  end

  before do
    render
  end

  it 'has an opening paragraph' do
    expect(rendered).to have_text('This professional development programme is designed to enhance how you teach secondary computing')
  end

  it 'has a benefits section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Benifits to you')
  end

  it 'has a pathway wrapper' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'How does the programme work?')
  end

  it 'has pathway cards' do
    expect(rendered).to have_css('.bordered-card')
    expect(rendered).to have_css('.govuk-heading-m', text: pathways.first.title)
  end

  it 'has subject expert support' do
    expect(rendered).to have_css('.govuk-heading-s', text: 'Subject Expert support')
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
