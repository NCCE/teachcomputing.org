task add_new_academic_year_badges_and_update_enabled_badges: :environment do
  latest_secondary_badge = Programme.secondary_certificate.badges.active.first
  latest_primary_badge = Programme.primary_certificate.badges.active.first
  latest_csa_badge = Programme.cs_accelerator.badges.active.first

  latest_secondary_badge.update_attribute(active: false)
  latest_primary_badge.update_attribute(active: false)
  latest_csa_badge.update_attribute(active: false)

  Badge.create(credly_badge_template_id: '', academic_year: '2021-22', active: true, programme_id: Programme.secondary_certificate.id)
  Badge.create(credly_badge_template_id: '', academic_year: '2021-22', active: true, programme_id: Programme.primary_certificate.id)
  Badge.create(credly_badge_template_id: '', academic_year: '2021-22', active: true, programme_id: Programme.cs_accelerator.id)
end
