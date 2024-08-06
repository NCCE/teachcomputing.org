namespace :badges do
  task setup_qa_badges: :environment do
    raise "You should not run this in production" if Rails.env.production?

    cpd_badges = [
      {
        programme: Programme.primary_certificate,
        credly_badge_template_id: "fa9bd16b-1299-4a28-906d-032c2b3317d6"
      },
      {
        programme: Programme.secondary_certificate,
        credly_badge_template_id: "af0e4473-8715-47ec-a896-69a6e22923f7"
      },
      {
        programme: Programme.cs_accelerator,
        credly_badge_template_id: "3ed1c4ad-98de-48f5-8071-7332c74ca96a"
      },
      {
        programme: Programme.i_belong,
        credly_badge_template_id: "35b3896a-4939-4bb5-8890-4992fabba67d"
      }
    ]

    completion_badges = [
      {
        programme: Programme.primary_certificate,
        credly_badge_template_id: "17fbf156-4bfe-47bc-875a-eb0b6efa8e64"
      },
      {
        programme: Programme.secondary_certificate,
        credly_badge_template_id: "7eecda8c-1d8f-45d0-98a4-b70407150388"
      },
      {
        programme: Programme.cs_accelerator,
        credly_badge_template_id: "2e13b4db-08da-41ff-9276-9aa3b02ee466"
      },
      {
        programme: Programme.a_level,
        credly_badge_template_id: "3b332362-8af1-4a8f-be04-385625f4efd0"
      }
    ]

    cpd_badges.each do |badge_data|
      Badge.find_or_create_by(credly_badge_template_id: badge_data[:credly_badge_template_id]).tap do |badge|
        badge.programme = badge_data[:programme]
        badge.active = true
        badge.trigger_type = :cpd
        badge.academic_year = "2023-24"
        badge.activation_date = Date.new(2024, 7, 1)
      end.save!
    end

    completion_badges.each do |badge_data|
      Badge.find_or_create_by(credly_badge_template_id: badge_data[:credly_badge_template_id]).tap do |badge|
        badge.programme = badge_data[:programme]
        badge.active = true
        badge.trigger_type = :completion
        badge.academic_year = "2023-24"
        badge.activation_date = Date.new(2024, 7, 1)
      end.save!
    end
  end
end
