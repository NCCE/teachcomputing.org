FactoryBot.define do
  factory :fl_organisation_membership, class: Hash do
    uuid { SecureRandom.uuid }
    href { 'https://testapi.com/partners/organisation_memberships/membership_uuid' }
    external_learner_id { SecureRandom.uuid }

    initialize_with { attributes }
  end
end
