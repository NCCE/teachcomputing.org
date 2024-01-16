namespace :report_generation do
  desc "Generates a report of all the users"
  task generate_user_report: :environment do
    ReportGeneration.generate_user_report
  end
end
