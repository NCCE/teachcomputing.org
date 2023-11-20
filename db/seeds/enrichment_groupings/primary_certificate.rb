include ExternalLinkHelper

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
    e.body = "In the Moon Camp Challenge pupils can explore and design their own Moon settlement with a 3D modelling tool.<br><br><a href=\"#{primary_mooncamp_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 1
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Astro Pi').tap do |e|
    e.title = 'Astro Pi'
    e.title_url = 'https://astro-pi.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/astro_pi.png'
    e.body = "An opportunity for young people to carry out their own scientific investigations in space, writing computer programs that will run aboard the International Space Station.<br><br><a href=\"#{primary_astro_pi_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 2
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Climate Detectives').tap do |e|
    e.title = 'Climate Detectives'
    e.title_url = 'https://www.stem.org.uk/esero/primary/competitions-and-challenges/climate-detectives'
    e.image_url = 'https://static.teachcomputing.org/enrichment/climate_detectives.png'
    e.body = "Teams of pupils are called to make a difference by identifying a climate problem, investigating it by using available Earth Observation data or taking measurements on the ground, and then proposing a way to help reduce the problem.<br><br><a href=\"#{climate_detectives_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 3
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Spring term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Spring term'
  g.term_start = DateTime.new(2024, 1, 1)
  g.term_end = DateTime.new(2024, 4, 14)
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Tech she can').tap do |e|
    e.title = 'Tech she can'
    e.title_url = 'https://techshecan.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/tech_she_can.png'
    e.body = "Join Becky Patel, Head of Education and Learning for the charity Tech She Can as she explains how to use the freely available Tech We Can educational resources to inspire children aged 5-14 to consider a future career in technology.<br><br><a href=\"#{tech_she_can_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 1
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Into film').tap do |e|
    e.title = 'Into film'
    e.title_url = 'https://www.intofilm.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/into_film.png'
    e.body = "Support young people to learn through film and the moving image and explore how you can bring the power of moving image storytelling into classroom teaching.<br><br><a href=\"#{into_film_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 2
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Micro:bit the Next Gen').tap do |e|
    e.title = 'Micro:bit the Next Gen'
    e.title_url = 'https://www.bbc.co.uk/teach/microbit?ref=blog.teachcomputing.org'
    e.image_url = 'https://static.teachcomputing.org/enrichment/do_your_bit.png'
    e.body = "As part of the BBC micro:bit - the next gen campaign, your primary school pupils can get involved in a large-scale playground survey during the summer term next year.<br><br><a href=\"#{micro_bit_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 3
  end.save

end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Summer term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Summer term'
  g.term_start = DateTime.new(2024, 4, 15)
  g.term_end = DateTime.new(2024, 9, 3)
  g.coming_soon = true

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Do your: bit').tap do |e|
    e.title = 'Do your: bit'
    e.title_url = 'https://microbit.org/teach/do-your-bit/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/do_your_bit.png'
    e.body = "Bring together the micro:bit and the UN’s Global Goals to provide inspiring activities for your classroom or club and an exciting digital challenge for you to run.<br><br><a href=\"#{do_your_bit_webinar_url}\">Join the webinar to find out more</a>"
    e.order = 1
  end.save

end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Activities throughout the year').becomes!(EnrichmentGroupings::AllYear).tap do |g|
  g.title = 'Activities throughout the year'
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Set up a STEM Club').tap do |e|
    e.title = 'Set up a STEM Club'
    e.title_url = 'https://www.stem.org.uk/primary/enrichment/stem-clubs'
    e.image_url = 'https://static.teachcomputing.org/enrichment/stem_clubs.png'
    e.body = "Out-of-timetable sessions that enrich and broaden the curriculum, giving young people the chance to explore subjects like science, technology, engineering and maths in less formal settings.<br><br><a href=\"#{stem_club_url}\">Find out more and get started</a>"
    e.order = 1
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Bebras Challenge').tap do |e|
    e.title = 'Bebras Challenge'
    e.title_url = 'https://www.bebras.uk/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/bebras.png'
    e.body = 'A computational thinking challenge that aims to enthuse students in all things computer science and promote computational thinking.'
    e.order = 2
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Micro:bit the Next Gen').tap do |e|
    e.title = 'Micro:bit the Next Gen'
    e.title_url = 'https://www.bbc.co.uk/teach/microbit?ref=www.teachcomputing.org/blog'
    e.image_url = 'https://static.teachcomputing.org/enrichment/micro_bit.png'
    e.body = 'Register for free Micro:bits before December 2023 and training on how to use them in the Next Gen Campaign.'
    e.order = 3
  end.save
end.save
