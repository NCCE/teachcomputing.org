module TrackingHelper
  include Rails.application.routes.url_helpers

  def tracking_category
    category_map = [
      { route: curriculum_key_stages_path, category: 'Curriculum landing' },
      { route: about_path, category: 'About' },
      { route: gender_balance_path, category: 'GBIC' },
      { route: hubs_path, category: 'Hubs' },
      { route: impact_path, category: 'Impact' },
      { route: primary_path, category: 'Primary unenrolled' },
      { route: primary_certificate_path, category: 'Primary enrolled' }
    ]

    category_map.each do |item|
      return item[:category] if item[:route] == request.path
    end

    nil
  end

  def tracking_data(label, category = nil)
    category ||= tracking_category
    return unless category

    { event_action: 'click', event_category: category, event_label: label }
  end
end
