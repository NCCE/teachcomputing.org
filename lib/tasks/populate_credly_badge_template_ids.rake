task populate_credly_badge_template_ids: :environment do
  Programme.cs_accelerator.update(credly_badge_template_id: 'e5d5cfea-4d05-4293-9a21-c319088a1e78')
  Programme.primary_certificate.update(credly_badge_template_id: 'b013421f-1a8f-4630-8c3c-17b3bfc58463')
end
