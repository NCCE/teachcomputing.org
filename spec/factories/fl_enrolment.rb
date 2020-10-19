FactoryBot.define do
  factory :fl_enrolment, class: Hash do
    transient do
      run_uuid { SecureRandom.uuid }
      membership_uuid { SecureRandom.uuid }
    end

    run do
      {
        uuid: run_uuid,
        href: 'https://testapi.com/partners/course_runs/d2acdb39-f6cb-45da-8c37-681d3b4d2911'
      }
    end
    organisation_membership do
      {
        uuid: membership_uuid,
        href: 'https://testapi.com/partners/organisation_memberships/0ea0e41f-5620-4a91-a1c7-2a15ecf16a06'
      }
    end
    status { 'active' }
    activated_at { DateTime.now.to_s }
    deactivated_at { nil }
    steps_completed_count { 30 }
    steps_completed_ratio { 0.7 }

    initialize_with { attributes }
  end
end
