require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let!(:programme) { create(:cs_accelerator) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  before do
		create(:primary_certificate)
		create(:secondary_certificate)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @incomplete_achievements = []
    @completed_achievements = []
  end

  context 'when the user has not enrolled' do
    before do
      render
    end

    it 'has a title' do
      expect(rendered).to have_css('h1', text: 'Your dashboard')
    end

    it 'has courses section' do
      expect(rendered).to have_css('h2', text: 'Your courses')
    end
  end

  context 'when the user has enrolled on a programme' do
    before do
      user_programme_enrolment
      user.reload
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Certificates')
    end
  end

  context 'when there are no achievements' do
    before do
      render
    end

    it 'has no activity list' do
      expect(rendered).not_to have_css('.ncce-activity-list')
    end

    it 'shows the placeholder content' do
      expect(rendered).to have_link('Find a course', href: '/courses')
    end
  end

  context 'when there are only incomplete achievements' do
    before do
      @incomplete_achievements = [create(:achievement, user: user, programme_id: programme.id)]
      render
    end

    it 'renders a checkbox with no ticks' do
      expect(rendered).to have_css('.ncce-activity-list__item-text--incomplete')
    end

    it 'shows the enrolled prefix' do
      expect(rendered).to have_text('Enrolled Dec 2020')
    end

    it "does not show the placeholder content" do
      expect(rendered).not_to have_link('Find a course', href: '/courses')
    end

    it "does not render an empty list for complete achievements" do
      expect(rendered).to have_css('.ncce-activity-list', count: 1)
    end
  end

  context 'when there are only complete achievements' do
    before do
      @completed_achievements = [create(:completed_achievement, user: user, programme_id: programme.id)]
      render
    end

    it 'renders a checkbox with ticks' do
      expect(rendered).to have_css('.ncce-activity-list__item-text')
    end

    it 'shows the completed prefix' do
      expect(rendered).to have_text('Completed Dec 2020')
    end

    it "does not show the placeholder content" do
      expect(rendered).not_to have_link('Find a course', href: '/courses')
    end

    it "does not render an empty list for incomplete achievements" do
      expect(rendered).to have_css('.ncce-activity-list', count: 1)
    end
  end

  context 'when there are both complete and incomplete achievements' do
    before do
      @incomplete_achievements = create_list(:achievement, 2, user: user, programme_id: programme.id)
      @completed_achievements = create_list(:completed_achievement, 2, user: user, programme_id: programme.id)
      render
    end

    it 'has an activity list with the expected number of items' do
      expect(rendered).to have_css('.ncce-activity-list li', count: 4)
    end

    it "does not show the placeholder content" do
      expect(rendered).not_to have_link('Find a course', href: '/courses')
    end
  end

  context "when there's an achievement not part of a programme" do
    before do
      @incomplete_achievements = [create(:achievement, user: user)]
      render
    end

    it 'has an activity list with the expected number of items' do
      expect(rendered).to have_css('.ncce-activity-list li', count: 1)
    end
  end
end
