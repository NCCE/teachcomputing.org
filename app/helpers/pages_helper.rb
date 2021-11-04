module PagesHelper
  def category
    case params[:page_slug]
    when 'gender-balance'
      'GBIC'
    end
  end

  def tracking(label)
    return unless category

    { event_action: 'click', event_category: category, event_label: label }
  end
end
