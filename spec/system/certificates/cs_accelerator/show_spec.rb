require 'rails_helper'

RSpec.describe('CS Accelerator certificate page') do
  let(:user) { create(:user, email: 'web@teachcomputing.org') }
  let(:programme) { create(:cs_accelerator) }
  let!(:assessment) { create(:assessment, programme_id: programme.id) }
  let!(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:diagostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:online_course) { create(:activity, :future_learn, credit: 20, programme_activities: [create(:programme_activity, programme:)]) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20, programme_activities: [create(:programme_activity, programme:)]) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    [online_achievement, face_to_face_achievement].each do |achievement|
      achievement.transition_to(:complete)
    end
    visit cs_accelerator_certificate_path
  end

  describe 'feedback form' do
    it 'renders the form' do
      expect(page).to have_content('Help us improve our certificate experience')
    end

    it 'shows success message when feedback submitted' do
      fill_in id: 'feedback_comment_comment', with: 'Feedback about things'
      click_on 'Submit'
      expect(page).to have_content('Your feedback was successfully submitted')
    end
  end

  describe 'test attempts' do
    it 'renders the exam conditions form' do
      expect(page).to have_content('I have read and accept the full exam conditions.')
    end

    describe 'the initial state of the form' do
      it 'has a disabled checkbox' do
        expect(page).to have_unchecked_field('assessment_attempt[accepted_conditions]', visible: :hidden)
      end

      it 'has a disabled submit button' do
        expect(page).to have_button('commit', disabled: true)
      end
    end

    describe 'the state of the form after conditions are accepted' do
      it 'has an enabled submit button' do
        check('assessment_attempt[accepted_conditions]', visible: false)
        expect(page).to have_button('commit', disabled: false)
      end
    end
  end
end
