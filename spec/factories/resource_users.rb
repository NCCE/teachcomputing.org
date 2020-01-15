FactoryBot.define do
  factory :resource_user do
    resource_year { 1 }
    user 
    count { 1 }
  end

  trait :year_3 do
    resource_year { 3 }
  end

end
