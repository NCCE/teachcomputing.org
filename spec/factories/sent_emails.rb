FactoryBot.define do
  factory :sent_email do
    user
    mailer_type { CSAcceleratorMailer::CSA_COMPLETED_EMAIL }
    subject { "This is your completed email" }
  end
end
