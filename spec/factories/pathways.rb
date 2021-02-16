FactoryBot.define do
  factory :pathway do
    range { 1..10 }
    title { 'Pathway' }
    description { 'Pathway description' }
    pdf_link { 'https://example.com/pdf-link.pdf' }
    slug { 'slug' }

    trait :new_to_computing do
      slug { 'new-to-computing' }
    end
    factory :new_to_computing, traits: %i[new_to_computing]

    trait :prepare_to_teach_gcse_computer_science do
      slug { 'prepare-to-teach-gcse-computer-science' }
    end
    factory :prepare_to_teach_gcse_computer_science, traits: %i[prepare_to_teach_gcse_computer_science]

    trait :new_to_algorithms_and_programming do
      slug { 'new-to-algorithms-and-programming' }
    end
    factory :new_to_algorithms_and_programming, traits: %i[new_to_algorithms_and_programming]

    trait :new_to_computer_systems do
      slug { 'new-to-computer-systems' }
    end
    factory :new_to_computer_systems, traits: %i[new_to_computer_systems]

    trait :advanced_gcse_computer_science do
      slug { 'advanced-gcse-computer-science' }
    end
    factory :advanced_gcse_computer_science, traits: %i[advanced_gcse_computer_science]
  end
end
