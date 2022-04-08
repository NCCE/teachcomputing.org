module TrackingHelper
  include Rails.application.routes.url_helpers

  def tracking_categories
    @tracking_categories ||= {
      curriculum_key_stages_path => 'Curriculum landing',
      about_path => 'About',
      gender_balance_path => 'GBIC',
      hubs_path => 'Hubs',
      impact_path => 'Impact',
      primary_path => 'Primary unenrolled',
      primary_certificate_path => 'Primary enrolled'
    }
  end

  def tracking_category
    tracking_categories.fetch(request.path, nil)
  end

  def tracking_data(label, category = nil)
    category ||= tracking_category
    return unless category

    { event_action: 'click', event_category: category, event_label: label }
  end
end
