programme = Programme.secondary_certificate

programme.enrichment_groupings.find_or_initialize_by(title: 'Autumn term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Autumn term'
  g.term_start = DateTime.new(2023, 9, 4)
  g.term_end = DateTime.new(2024, 12, 21)

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase 1').tap do |e|
    e.title = 'Apps for good showcase 1'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase 2').tap do |e|
    e.title = 'Apps for good showcase 2'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Spring term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Spring term'
  g.term_start = DateTime.new(2024, 1, 1)
  g.term_end = DateTime.new(2024, 4, 14)

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase 1').tap do |e|
    e.title = 'Apps for good showcase 1'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Summer term').becomes(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Summer term'
  g.term_start = DateTime.new(2024, 4, 15)
  g.term_end = DateTime.new(2024, 9, 3)

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Activities throughout the year').becomes(EnrichmentGroupings::AllYear).tap do |g|
  g.title = 'Activities throughout the year'

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase').tap do |e|
    e.title = 'Apps for good showcase'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for good showcase 1').tap do |e|
    e.title = 'Apps for good showcase 1'
    e.title_url = '#'
    e.image_url = 'https://static.teachcomputing.org/enrichment_entries/apps_for_good.png'
    e.body = 'An annual celebration of young tech innovators.'
  end.save
end.save
