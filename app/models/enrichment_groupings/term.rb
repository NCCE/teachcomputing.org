class EnrichmentGroupings::Term < EnrichmentGrouping
  with_options presence: true do
    validates :term_start
    validates :term_end
  end

  def is_current_term?
    return false if coming_soon

    (normalised_start..normalised_end).cover?(normalised_current_date)
  end

  def days_till_term
    return 0 if is_current_term?
    return Float::INFINITY if coming_soon

    difference_in_days = normalised_start.to_datetime - normalised_current_date

    if difference_in_days.negative?
      365 - difference_in_days
    else
      difference_in_days
    end
  end

  private

  def normalised_start
    normalised_start = term_start.change(year: 2000)
  end

  def normalised_end
    normalised_end = term_end.change(year: 2000)
  end

  def normalised_current_date
    DateTime.now.change(year: 2000)
  end
end
