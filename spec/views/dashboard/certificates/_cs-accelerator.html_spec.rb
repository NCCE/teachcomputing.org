require 'rails_helper'

RSpec.describe('dashboard/certificates/_cs-accelerator') do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:cs_accelerator) }
  let(:programmes) { Programme.enrollable }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  before do
    [programme, @programmes = programmes, activity]
    programme_activity
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user:)
    @achievements = user.achievements
    render template: 'dashboard/certificates/_cs-accelerator', locals: { programme: }
  end

  context 'when the user has enrolled onto the CS Accelerator programme' do
    before do
      user_programme_enrolment
      user.reload
      render template: 'dashboard/certificates/_cs-accelerator', locals: { programme: }
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link('KS3 and GCSE Computer Science subject knowledge', href: cs_accelerator_path)
    end
  end

  context 'when the user has completed the CS Accelerator programme' do
    before do
      user_programme_enrolment.transition_to(:pending)
      passed_exam
      user.reload
      render template: 'dashboard/certificates/_cs-accelerator', locals: { programme: }
    end

    it 'shows the completed text' do
      expect(rendered).to have_css('.status-block-light', text: 'Programme complete')
    end
  end

  context 'when the user has been awarded the CS Accelerator certificate' do
    before do
      user_programme_enrolment.transition_to(:complete)
      passed_exam
      user.reload
      render template: 'dashboard/certificates/_cs-accelerator', locals: { programme: }
    end

    it 'shows the completed text' do
      expect(rendered).to have_css('.status-block-light', text: 'Certificate awarded')
    end
  end
end
