module EnrichmentGroupingHelper
  def order_enrichment_groupings_by_proximity(groupings)
    term_groupings, all_year_groupings = groupings.partition do |grouping|
      grouping.is_a? EnrichmentGroupings::Term
    end

    today = DateTime.new

    ordered_groupings = term_groupings.sort_by do |grouping|

    end
  end
end
