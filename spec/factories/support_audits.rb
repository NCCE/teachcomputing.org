FactoryBot.define do
  factory :support_audit do
    user
    associated { association :assessment_attempt }
    authoriser
    comment { "Changed something" }
    audited_changes {
      {
        accepted_conditions: false
      }
    }
  end
end
