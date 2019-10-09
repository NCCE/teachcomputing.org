require 'rails_helper'

RSpec.describe('dashboard/programmes/_hero', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }
  let(:programme) { create(:cs_accelerator) }
  let(:programmes) { Programme.enrollable }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  before do
    [programme, @programmes = programmes, activity]
    programme_activity
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    @achievements = user.achievements
    render :template => 'dashboard/programmes/_hero', :locals => { programme: programme }
  end

  context 'when the user has enrolled onto the CS Accelerator programme' do
    before do
      user_programme_enrolment
      user.reload
      render :template => 'dashboard/programmes/_hero'
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link(programme.title, href: programme_path(slug: programme.slug))
    end

    it 'shows the progress bar' do
      expect(rendered).to have_css('.certification-progress__bar', count: 1)
    end
  end

  context 'when the user has completed the CS Accelerator programme' do
    before do
      user_programme_enrolment
      passed_exam
      user.reload
      render :template => 'dashboard/programmes/_hero', :locals => { programme: programme }
    end

    it 'shows the certificate complete section' do
      expect(rendered).to have_css('.underlined__title', text: 'Your certificate')
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link(programme.title, href: programme_complete_path(slug: programme.slug))
    end

    it 'shows the completed text' do
      expect(rendered).to have_css('.pink-text', text: 'Completed!')
    end

    it 'shows the image' do
        expect(rendered).to have_css('.hero__image--dashboard', count: 1)
    end
  end
end
