require 'rails_helper'

RSpec.describe('pages/enrolment/cs_accelerator', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  before do
    @programme = programme
    render
  end

  it 'has diagram' do
    expect(rendered).to have_css('.pathway-wrapper', count: 1)
  end

  it 'has aside section' do
    expect(rendered).to have_css('.aside-component', count: 3)
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has Enrol title' do
      expect(rendered).to have_css('.aside-component__heading', text: 'Enrol')
    end

    it 'has Enrol button' do
      expect(rendered).to have_css('.button--aside', text: 'Enrol on this certificate')
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has How to enrol title' do
      expect(rendered).to have_css('.aside-component__heading', text: 'Enrol on the programme')
    end

    it 'has a button to log in' do
      expect(rendered).to have_css('.button--aside', text: 'Log in')
    end
  end

  context 'useful links and documents' do
    it 'has link to csa brochure' do
      expect(rendered).to have_css('.ncce-link', text: 'CSA Handbook')
    end

    it 'has link to csa course map' do
      expect(rendered).to have_css('.ncce-link', text: 'GCSE specification map')
    end
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
