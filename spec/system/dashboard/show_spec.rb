require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Dashboard page', type: :system) do
  let(:user) { create(:user) }
  let(:achievement) { build(:achievement, :online) }
  let(:jan31_user_course_details) do
    Achiever::Course::Delegate.new(
      JSON.parse({
                  "Activity.COURSETEMPLATENO": achievement.activity.stem_course_template_no,
                  "Delegate.Is_Fully_Attended": 'True',
                  "OnlineCPD": true,
                  "Activity.StartDate": "31\/01\/2023 00:00:00",
                 }.to_json, object_class: OpenStruct))
  end

  before do
    stub_attendance_sets
    stub_delegate

    create(:primary_certificate)
    create(:cs_accelerator)
    create(:secondary_certificate)
    create(:i_belong)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  it 'is the correct page' do
    visit dashboard_path
    expect(page).to have_content('Your dashboard')
  end

  it 'main is accessible' do
    visit dashboard_path
    # Remove .ncce-link exclusion when https://github.com/NCCE/teachcomputing.org-issues/issues/858 addressed.
    expect(page).to be_accessible.within('#main-content').excluding('.ncce-link')
  end

  it 'shows future availability of an online course' do
    Timecop.freeze(2023, 1, 30) do
      user.achievements << achievement

      allow(Achiever::Course::Delegate).to receive(:find_by_achiever_contact_number)
        .and_return([jan31_user_course_details])

      visit dashboard_path
      expect(page).to have_text('Available from 31 January 2023')
    end
  end

  it 'omits availability of an online course that already started' do
    Timecop.freeze(2023, 1, 31) do
      user.achievements << achievement

      allow(Achiever::Course::Delegate).to receive(:find_by_achiever_contact_number)
        .and_return([jan31_user_course_details])

      visit dashboard_path
      expect(page).not_to have_text('Available from')
    end
  end
end
