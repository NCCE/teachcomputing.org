FactoryBot.define do
  factory :feedback_comment do
    area { "feedback_area" }
    comment { "A feedback comment" }
    user
  end
end
