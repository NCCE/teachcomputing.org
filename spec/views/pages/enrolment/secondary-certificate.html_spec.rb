require 'rails_helper'

RSpec.describe('pages/enrolment/secondary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'secondary-certificate') }

  context 'when a user is not signed in' do
    before do
      stub_feature_flags({ primary_redesign_enabled: true })
      @programme = programme
      assign(:current_user, nil)
      allow(view).to receive(:eligible_for_secondary?).and_return(false)
      render
    end

    after do
      unstub_feature_flags
    end

    it 'has a heading' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Welcome to the Secondary Computing Programme')
    end

    it 'has diagram' do
      expect(rendered).to have_css('.pathway-wrapper', count: 1)
    end

    it 'has aside section' do
      expect(rendered).to have_css('.ncce-aside', count: 1)
    end

    it 'has expected title' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'How to enrol')
    end

    it 'has csa enrolment link' do
      expect(rendered).to have_link('the Computer Science Accelerator programme', href: '/cs-accelerator', count: 2)
    end

    it 'has Account button' do
      expect(rendered).to have_css('.button--aside', text: 'Create an account')
    end

    it 'has Login button' do
      expect(rendered).to have_link('log in', href: '/auth/stem')
    end
  end

  context 'when a user is signed in but not enrolled' do
    before do
      @programme = programme
      assign(:current_user, user)
      allow(view).to receive(:eligible_for_secondary?).and_return(false)
      render
    end

    it 'has csa enrolment link' do
      expect(rendered).to have_link('the Computer Science Accelerator programme', href: '/cs-accelerator', count: 2)
    end

    it 'has no Enrol button' do
      expect(rendered).not_to have_css('.button--aside', text: 'Enrol on this certificate')
    end

    it 'has no Login button' do
      expect(rendered).not_to have_link('log in', href: '/auth/stem')
    end
  end

  context 'when a user is signed in and enrolled' do
    before do
      @programme = programme
      assign(:current_user, user)
      allow(view).to receive(:eligible_for_secondary?).and_return(true)
      render
    end

    it 'has no csa enrolment link' do
      expect(rendered).not_to have_text(/Successfully complete the Computer Science Accelerator programme/)
    end

    it 'has Enrol button' do
      expect(rendered).to have_css('.button--aside', text: 'Enrol on this certificate')
    end

    it 'has no Login button' do
      expect(rendered).not_to have_link('log in', href: '/auth/stem')
    end
  end
end
