class EnrichmentGroupings::Term < EnrichmentGrouping
  with_options presence: true do
    validates :term_start
    validates :term_end
  end

  def is_current_term?
    (normalised_start..normalised_end).cover?(normalised_current_date)
  end

  private

  def normalised_start
    normalise_date(term_start)
  end

  def normalised_end
    normalise_date(term_end)
  end

  def normalised_current_date
    normalise_date(DateTime.now)
  end

  def normalise_date(date)
    this_year = Time.zone.today.year
    date_year = date.year

    year_to_normalise_to = this_year + (date_year - this_year)

    date.change(year: year_to_normalise_to)
  end
end
