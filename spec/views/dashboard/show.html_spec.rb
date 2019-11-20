require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @achievements = []
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Your dashboard')
  end

  it 'has progress section' do
    expect(rendered).to have_css('h2', text: 'Your activity')
  end

  it 'doesn\'t show the activity list' do
    expect(rendered).not_to have_css('.ncce-activity-list li', count: 2)
  end

  it 'shows the find courses button' do
    expect(rendered).to have_link('Find a course', href: courses_path)
  end

  context 'when the user has completed some achievements' do
    before do
      [programme, @programmes = Programme.all, activity]
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      create(:achievement, user: user)
      @achievements = user.achievements
      render
    end

    it 'shows the activity list' do
      expect(rendered).to have_css('.ncce-activity-list li', count: 2)
    end

    it 'does not show the certificate progress section' do
      expect(rendered).not_to have_css('.govuk-heading-m', text: 'Your certificates')
    end
  end

  context 'when the user has enrolled on a programme' do
    before do
      user_programme_enrolment
      user.reload
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Your certificates')
    end
  end

end
