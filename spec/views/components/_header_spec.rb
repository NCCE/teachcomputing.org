require 'rails_helper'

RSpec.describe('components/_header', type: :view) do
  let(:user) { create(:user) }
  let(:enrolment) do
    create(:user_programme_enrolment,
           user: user,
           programme: create(:cs_accelerator))
  end

  it 'has a link to the home page ' do
    render
    expect(rendered).to have_xpath('//a[@href = "/"][contains(@class, "govuk-header__link")]', count: 1)
  end

  it 'shows a link to Primary teachers' do
    render
    expect(rendered).to have_link('Primary teacher toolkit', href: '/primary-teachers')
  end

  it 'shows a link to Secondary teachers' do
    render
    expect(rendered).to have_link('Teacher certification', href: '/secondary-certification')
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      enrolment
      render
    end

    context 'when enrolled on a certificate' do
      it 'shows a link to your your certificate' do
        expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Your dashboard')
      end

      it 'shows a link to your edit profile' do
        expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Edit profile')
      end

      it 'shows a link to logout' do
        expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Logout')
      end
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'shows link to sign up' do
      expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Create an account')
    end

    it 'shows link to log in' do
      expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Log in')
    end

    it 'does not show a link to your dashboard' do
      expect(rendered).not_to have_css('.govuk-header__navigation-item', text: 'Your dashboard')
    end
  end
end
