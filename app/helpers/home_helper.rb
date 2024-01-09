module HomeHelper
  def published_date(iso_date)
    return if iso_date.blank?

    "#{DateTime.parse(iso_date).strftime("%-d %B %Y")}"
  end
end
