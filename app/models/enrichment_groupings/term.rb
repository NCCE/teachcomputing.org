class EnrichmentGroupings::Term < EnrichmentGrouping
  with_options presence: true do
    validates :term_start
    validates :term_end
  end

  def is_current_term?
    (term_start..term_end).cover?(DateTime.now)
  end

  def days_till_term
    return 0 if is_current_term?

    difference_in_days = (term_start.to_datetime - DateTime.now).to_i

    if difference_in_days.negative?
      365 + difference_in_days
    else
      difference_in_days
    end
  end

end
