namespace :new_assesment_eligibility do
  task schedule: :environment do

    User.all.each do |user|
      NewAssessmentEligibilityJob.perform_now(user.id)
    end
  end
end
