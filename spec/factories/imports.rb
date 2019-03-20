FactoryBot.define do
  factory :import do
    provider { 'future-learn' }
    triggered_by { 'user@raspberrypi.org' }
    activity
  end
end
