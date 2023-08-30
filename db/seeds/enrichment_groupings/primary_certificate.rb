programme = Programme.primary_certificate

programme.enrichment_groupings.find_or_initialize_by(title: 'Autumn term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Autumn term'
  g.term_start = DateTime.new(2023, 9, 4)
  g.term_end = DateTime.new(2024, 12, 21)
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Moon Camp').tap do |e|
    e.title = 'Moon Camp'
    e.title_url = 'https://mooncampchallenge.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/moon_camp.png'
    e.body = 'In the Moon Camp Challenge pupils can explore and design their own Moon settlement with a 3D modelling tool.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Astro Pi').tap do |e|
    e.title = 'Astro Pi'
    e.title_url = 'Apps for good showcase'
    e.image_url = 'https://static.teachcomputing.org/enrichment/astro_pi.png'
    e.body = 'An opportunity for young people to carry out their own scientific investigations in space, writing computer programs that will run aboard the International Space Station.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Climate Detectives').tap do |e|
    e.title = 'Climate Detectives'
    e.title_url = 'https://www.stem.org.uk/esero/primary/competitions-and-challenges/climate-detectives'
    e.image_url = 'https://static.teachcomputing.org/enrichment/climate_detectives.png'
    e.body = 'Teams of pupils are called to make a difference by identifying a climate problem, investigating it by using available Earth Observation data or taking measurements on the ground, and then proposing a way to help reduce the problem.'
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Spring term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Spring term'
  g.term_start = DateTime.new(2024, 1, 1)
  g.term_end = DateTime.new(2024, 4, 14)
  g.coming_soon = true

  g.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Summer term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Summer term'
  g.term_start = DateTime.new(2024, 4, 15)
  g.term_end = DateTime.new(2024, 9, 3)
  g.coming_soon = true

  g.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Activities throughout the year').becomes!(EnrichmentGroupings::AllYear).tap do |g|
  g.title = 'Activities throughout the year'
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Bebras Challenge').tap do |e|
    e.title = 'Bebras Challenge'
    e.title_url = 'https://www.bebras.uk/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/bebras.png'
    e.body = 'A computational thinking challenge that aims to enthuse students in all things computer science and promote computational thinking.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'STEM Clubs resources').tap do |e|
    e.title = 'STEM Clubs resources'
    e.title_url = 'https://www.stem.org.uk/primary/enrichment/stem-clubs'
    e.image_url = 'https://static.teachcomputing.org/enrichment/stem_clubs.png'
    e.body = 'Out-of-timetable sessions that enrich and broaden the curriculum, giving young people the chance to explore subjects like science, technology, engineering and maths in less formal settings.'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Micro:bit the Next Gen').tap do |e|
    e.title = 'Micro:bit the Next Gen'
    e.title_url = 'https://www.bbc.co.uk/teach/microbit?ref=blog.teachcomputing.org'
    e.image_url = 'https://static.teachcomputing.org/enrichment/micro_bit.png'
    e.body = 'Register for free Micro:bits before December 2023 and training on how to use them in the Next Gen Campaign.'
  end.save
end.save
