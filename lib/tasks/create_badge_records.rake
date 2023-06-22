task create_badge_records: :environment do
  primary_certificate = Programme.primary_certificate
  cs_accelerator = Programme.cs_accelerator
  secondary_certificate = Programme.secondary_certificate
  primary_2019_2020 = '621584fd-1f8f-4bb1-a60e-dd015d9fc787'
  primary_2020_2021 = 'e5d5cfea-4d05-4293-9a21-c319088a1e78'
  csa_2019_2020 = '67d40ae8-a7a8-4c33-bd6a-11031bb80f18'
  csa_2020_2021 = 'b013421f-1a8f-4630-8c3c-17b3bfc58463'
  secondary_2020_21 = 'a03f3f66-72ec-400f-9935-17477a5c1192'

  Rails.logger.warn "Creating badge records"
  Badge.create(credly_badge_template_id: primary_2019_2020, academic_year: '2019-20', active: false, programme_id: primary_certificate.id)
  Badge.create(credly_badge_template_id: primary_2020_2021, academic_year: '2020-21', active: true, programme_id: primary_certificate.id)
  Badge.create(credly_badge_template_id: csa_2019_2020, academic_year: '2019-20', active: false, programme_id: cs_accelerator.id)
  Badge.create(credly_badge_template_id: csa_2020_2021, academic_year: '2020-21', active: true, programme_id: cs_accelerator.id)
end
