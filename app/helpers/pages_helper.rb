module PagesHelper
  def tracking_category
    categories = {
      gender_balance: 'GBIC',
      primary_certificate: 'Primary unenrolled',
      impact_and_evaluation: 'Impact',
      about: 'About'
    }
    slug = params[:page_slug]&.underscore&.to_sym
    categories.fetch(slug, '')
  end

  def tracking(label)
    return unless tracking_category

    { event_action: 'click', event_category: tracking_category, event_label: label }
  end
end
