module PagesHelper
  def category
    case params[:page_slug]
    when 'gender-balance'
      'GBIC'
    when 'primary-certificate'
      'Primary unenrolled'
    end
  end

  def tracking(label)
    return unless category

    { event_action: 'click', event_category: category, event_label: label }
  end
end
