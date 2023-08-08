class EnrichmentGroupings::Term < EnrichmentGrouping
  with_options presence: true do
    validates :term_start
    validates :term_end
  end
end
