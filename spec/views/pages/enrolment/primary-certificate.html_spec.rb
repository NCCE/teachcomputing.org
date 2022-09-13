require 'rails_helper'

RSpec.describe('pages/enrolment/primary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }

  before do
    @programme = programme
  end

  context 'when a user is not signed in' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has an opening paragraph' do
      expect(rendered).to have_text('We expect it to take around 20 hours to complete.')
    end

    it 'has a who section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Who is it for?')
    end

    it 'has a first time section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'First time teaching computing?')
    end

    it 'has a benefits section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'What are the benefits?')
    end

    it 'has a pathway wrapper' do
      expect(rendered).to have_css('.pathway__step-title', text: 'How does the programme work?')
    end

    it 'has the expected number of enrol buttons' do
      expect(rendered).to have_css('.govuk-button', count: 2, text: 'Enrol on this pathway')
    end

    it 'has a bursary support aside' do
      expect(rendered).to have_css('.bursary-component__title', text: 'Funding')
    end

    it 'has a hub aside' do
      expect(rendered).to have_css('.aside-component__heading', text: 'Get support')
      expect(rendered).to have_link('Find your local hub', href: '/hubs')
    end

    it 'has a create account link' do
      expect(rendered).to have_link('create an account', href: 'https://ncce-www-stage-int.stem.org.uk/user/register?from=NCCE')
    end

    it 'has a log in link' do
      expect(rendered).to have_link('log in', href: '/auth/stem')
    end
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'does not have a create account link' do
      expect(rendered).not_to have_css('.govuk-list li', text: 'create an account or log in to your existing account')
    end
  end
end
