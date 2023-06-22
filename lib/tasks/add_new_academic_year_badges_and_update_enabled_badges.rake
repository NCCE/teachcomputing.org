task add_new_academic_year_badges_and_update_enabled_badges: :environment do
  latest_secondary_badge = Programme.secondary_certificate.badges.active.first
  latest_primary_badge = Programme.primary_certificate.badges.active.first
  latest_csa_badge = Programme.cs_accelerator.badges.active.first

  latest_secondary_badge.update_attribute(:active, false)
  latest_primary_badge.update_attribute(:active, false)
  latest_csa_badge.update_attribute(:active, false)

  Badge.create(credly_badge_template_id: '6bff81ba-fabd-4854-8285-12c7bc3f38af', academic_year: '2022-23', active: true, programme_id: Programme.secondary_certificate.id)
  Badge.create(credly_badge_template_id: 'b3d46899-7dc9-4431-8f6d-2b66e8b15902', academic_year: '2022-23', active: true, programme_id: Programme.primary_certificate.id)
  Badge.create(credly_badge_template_id: '3d9fb0d9-99de-40f3-a97f-9829028d45d4', academic_year: '2022-23', active: true, programme_id: Programme.cs_accelerator.id)
  Rails.logger.warn "Updated with new academic badge years"
end
