include ExternalLinkHelper

programme = Programme.secondary_certificate

programme.enrichment_groupings.find_or_initialize_by(title: 'Autumn term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Autumn term'
  g.term_start = DateTime.new(2023, 9, 4)
  g.term_end = DateTime.new(2024, 12, 21)
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Cyber Centurion').tap do |e|
    e.title = 'Cyber Centurion'
    e.title_url = 'https://www.stem.org.uk/secondary/enrichment/competitions/cyber-centurion'
    e.image_url = 'https://static.teachcomputing.org/enrichment/cyber_centurion.png'
    e.body = "In the Cyber Centurion Competition teams compete in rounds against one another and the clock to secure a range of computer systems.<br><br><a href=\"#{cyber_centurion_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Moon Camp').tap do |e|
    e.title = 'Moon Camp'
    e.title_url = 'https://mooncampchallenge.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/moon_camp.png'
    e.body = "In the Moon Camp Challenge pupils can explore and design their own Moon settlement with a 3D modelling tool.<br><br><a href=\"#{secondary_mooncamp_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Astro Pi').tap do |e|
    e.title = 'Astro Pi'
    e.title_url = 'https://astro-pi.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/astro_pi.png'
    e.body = "An opportunity for young people to carry out their own scientific investigations in space, writing computer programs that will run aboard the International Space Station.<br><br><a href=\"#{secondary_astro_pi_webinar_url}\">Join the webinar to find out more</a>"
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
    e.body = 'A computational thinking challenge that aims to enthuse students in all things computer science and promote computational thinking.<br><br>Part of <a href="/i-belong">I Belong: Encouraging girls into computer science</a>'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'FIRST® LEGO® League').tap do |e|
    e.title = 'FIRST® LEGO® League'
    e.title_url = 'https://education.theiet.org/first-lego-league-programmes/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/first_lego_leauge.png'
    e.body = 'This is a global STEM programme where young people work together to explore a given topic and to design, build and program an autonomous LEGO® robot to solve a series of missions.<br><br>Part of <a href="/i-belong">I Belong: Encouraging girls into computer science</a>'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Cyber Security Challenge UK').tap do |e|
    e.title = 'Cyber Security Challenge UK'
    e.title_url = 'https://cybersecuritychallenge.org.uk'
    e.image_url = 'https://static.teachcomputing.org/enrichment/the_cyber_trust.png'
    e.body = 'From immersive afternoon workshops and modular cyber games to local careers fairs that bring together hundreds of students at a time, Cyber Security Challenge UK aims to raise awareness of the opportunities that exist in the industry. '
  end.save
end.save
