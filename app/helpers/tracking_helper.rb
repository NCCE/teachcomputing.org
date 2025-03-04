module TrackingHelper
  include Rails.application.routes.url_helpers

  def tracking_categories
    @tracking_categories ||= begin
      tracking_categories = {
        curriculum_key_stages_path => "Curriculum landing",
        about_path => "About",
        gender_balance_path => "GBIC",
        impact_path => "Impact",
        cms_page_path("primary-certificate") => "Primary unenrolled",
        primary_certificate_path => "Primary enrolled",
        secondary_path => "Secondary unenrolled",
        secondary_certificate_path => "Secondary enrolled",
        i_belong_path => "I Belong enrolled",
        courses_path => "Courses",
        cs_accelerator_certificate_path => "CSA enrolled",
        complete_cs_accelerator_certificate_path => "CSA Complete",
        cms_page_path("primary-early-careers") => "ECT primary",
        cms_page_path("secondary-early-careers") => "ECT secondary"
      }

      (1..4).each do |key_stage|
        key_stage_slug = "key-stage-#{key_stage}"
        path = curriculum_key_stage_units_path(key_stage_slug: key_stage_slug)

        tracking_categories[path] = "Key stage #{key_stage}"
      end

      tracking_categories
    end
  end

  def tracking_category
    tracking_categories.fetch(request.path, nil)
  end

  def tracking_data(label, category = nil)
    category ||= tracking_category
    return {} unless category

    {event_action: "click", event_category: category, event_label: label}
  end
end
