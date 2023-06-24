require 'rails_helper'

RSpec.describe 'schedule_cs_accelerator_eligible_courses_for_secondary_certificate_users', type: :task do 
    let!(:user) { create(:user) }
    let!(:secondary_certificate) { create(:secondary_certificate) }
    let!(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id) }
    let(:eligible_secondary_achievement) { create(:achievement, user_id: user.id, programme_id: secondary_certificate.id) }

    
    describe 'transitioning eligible user course enrolments'
        it 'changes a programme enrolment status to complete' do 
            eligible_secondary_achievement
            task.execute
            expect(CSAcceleratorEligibleCoursesForSecondaryCertificateUserJob).to have_been_enqueued
        end 
end 