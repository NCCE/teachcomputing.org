desc 'updates secondary certificate data'
task update_secondary_data: :environment do
  p = Programme.secondary_certificate

  p.activities.find_by(slug: 'complete-a-cs-accelerator-course').update(booking_programme_slug: 'cs-accelerator')
end
