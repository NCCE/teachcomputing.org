FactoryBot.define do
  factory :i_belong_certificate, class: 'Programmes::IBelongCertificate' do
    title { 'I Belong: encouraging girls into computer science' }
    slug { 'i-belong-certificate' }
    description { 'Encouraging girls into computer science' }
    enrollable { true }

    trait :with_activity_groupings do
      after(:create) do |programme|
        create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id)
      end
    end
  end
end

