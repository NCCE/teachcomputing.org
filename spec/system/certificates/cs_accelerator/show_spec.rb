require 'rails_helper'

RSpec.describe('CS Accelerator certificate page', type: :system) do
  let(:user) { create(:user) }
  let(:csa) { create(:cs_accelerator) }

  before do
    create(:user_programme_enrolment, user: user, programme: csa)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
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
end
