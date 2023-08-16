programme = Programme.primary_certificate

programme.enrichment_groupings.find_or_initialize_by(title: 'Autumn term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Autumn term'
  g.term_start = DateTime.new(2023, 9, 4)
  g.term_end = DateTime.new(2024, 1, 5)

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = '#'
    e.body = 'An annual celebration of young tech innovators.'
  end
end

programme.enrichment_groupings.find_or_initialize_by(title: 'Spring term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Spring term'
  g.term_start = DateTime.new(2024, 1, 5)
  g.term_end = DateTime.new(2024, 4, 12)

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = '#'
    e.body = 'An annual celebration of young tech innovators.'
  end
end

programme.enrichment_groupings.find_or_initialize_by(title: 'Summer term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Summer term'
  g.term_start = DateTime.new(2024, 2, 13)
  g.term_end = DateTime.new(2024, 9, 3)

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = '#'
    e.body = 'An annual celebration of young tech innovators.'
  end
end

programme.enrichment_groupings.find_or_initialize_by(title: 'Activities throughout the year').becomes(EnrichmentGroupings::AllYear).tap do |g|
  g.title = 'Activities throughout the year'

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = '#'
    e.body = 'An annual celebration of young tech innovators.'
  end
end
