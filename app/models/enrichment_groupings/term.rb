class EnrichmentGroupings::Term < EnrichmentGrouping
  with_options presence: true do
    validates :term_start
    validates :term_end
  end

  def is_current_term?
    (normalised_start..normalised_end).cover?(normalised_current_date)
  end

  def days_till_term
    return 0 if is_current_term?

    difference_in_days = (normalised_start.to_datetime - normalised_current_date).to_i

    if difference_in_days.negative?
      365 + difference_in_days
    else
      difference_in_days
    end
  end

  private

  def normalised_start
    normalised_start = normalise_date(term_start)
  end

  def normalised_end
    normalised_end = normalise_date(term_end)
  end

  def normalised_current_date
    normalise_date(DateTime.now)
  end

  def normalise_date(date)
    this_year = Date.today.year
    date_year = date.year

    year_to_normalise_to = this_year + (date_year - this_year)

    date.change(year: year_to_normalise_to)
  end
end
