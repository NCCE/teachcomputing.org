task populate_credly_badge_template_ids: :environment do
  primary_template_ids = ['621584fd-1f8f-4bb1-a60e-dd015d9fc787', 'e5d5cfea-4d05-4293-9a21-c319088a1e78']
  secondary_template_ids = []
  csa_template_ids = ['b013421f-1a8f-4630-8c3c-17b3bfc58463','67d40ae8-a7a8-4c33-bd6a-11031bb80f18']

  Programme.cs_accelerator.update(credly_badge_template_ids: csa_template_ids)
  Programme.primary_certificate.update(credly_badge_template_ids: primary_template_ids)
end
