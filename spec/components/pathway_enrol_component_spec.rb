require 'rails_helper'

RSpec.describe PathwayEnrolComponent, type: :component do
  let(:programme) { create(:primary_certificate) }
  let(:pathway) { create(:pathway, programme:, enrol_copy: ['<b class="test1">one</b>', '<b class="test2">two</b>']) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:, pathway:) }

  before do
    create(:cs_accelerator)
    programme
    pathway
    user
    user_programme_enrolment

    render_inline(described_class.new(programme:, pathway:, current_user: user))
  end

  context 'when the user is enrolled' do
    it 'should not render' do
      expect(page).to have_no_selector('body')
    end
  end

  context 'when the user is not enrolled' do
    let(:user_programme_enrolment) { nil }

    it 'should render' do
      expect(page).to have_selector('body')
    end

    it 'renders enrol_copy with html_safe' do
      expect(page).to have_css('.test1', text: 'one')
      expect(page).to have_css('.test2', text: 'two')
    end

    it 'renders an Enrol button' do
      expect(page).to have_css('.govuk-button', text: 'Enrol')
    end

    context 'when user doesn\'t meet enrolment requirements' do
      let(:programme) { create(:secondary_certificate) }

      it 'doesn\'t render an Enrol button' do
        expect(page).not_to have_css('.govuk-button', text: 'Enrol')
      end
    end
  end

  context 'when the user is not logged in' do
    let(:user_programme_enrolment) { nil }
    let(:user) { nil }

    it 'should render' do
      expect(page).to have_selector('body')
    end

    it 'renders enrol_copy with html_safe' do
      expect(page).to have_css('.test1', text: 'one')
      expect(page).to have_css('.test2', text: 'two')
    end

    it 'renders a register button' do
      expect(page).to have_css('.govuk-button', text: 'Create an account')
    end
  end
end
