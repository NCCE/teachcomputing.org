FactoryBot.define do
  factory :download do
    user_id { "ABC123" }
    aggregate_download
  end
end
