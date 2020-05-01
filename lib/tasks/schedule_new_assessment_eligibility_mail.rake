namespace :new_assesment_eligibility do
  task schedule: :environment do

    Programme.cs_accelerator.user_programme_enrolments.in_state(:enrolled).all.each do |enrolment|
      NewAssessmentEligibilityJob.perform_now(enrolment.user_id)
    end
  end
end
