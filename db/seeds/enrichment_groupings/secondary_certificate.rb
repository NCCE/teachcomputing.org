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
    e.i_belong = false
    e.title_url = 'https://www.stem.org.uk/secondary/enrichment/competitions/cyber-centurion'
    e.image_url = 'https://static.teachcomputing.org/enrichment/cyber_centurion.png'
    e.body = "In the Cyber Centurion Competition teams compete in rounds against one another and the clock to secure a range of computer systems.<br><br><a href=\"#{cyber_centurion_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Moon Camp').tap do |e|
    e.title = 'Moon Camp'
    e.i_belong = false
    e.title_url = 'https://mooncampchallenge.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/moon_camp.png'
    e.body = "In the Moon Camp Challenge pupils can explore and design their own Moon settlement with a 3D modelling tool.<br><br><a href=\"#{secondary_mooncamp_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Astro Pi').tap do |e|
    e.title = 'Astro Pi'
    e.i_belong = false
    e.title_url = 'https://astro-pi.org/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/astro_pi.png'
    e.body = "An opportunity for young people to carry out their own scientific investigations in space, writing computer programs that will run aboard the International Space Station.<br><br><a href=\"#{secondary_astro_pi_webinar_url}\">Join the webinar to find out more</a>"
  end.save
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Spring term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Spring term'
  g.term_start = DateTime.new(2024, 1, 1)
  g.term_end = DateTime.new(2024, 4, 14)
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Apps for Good showcase').tap do |e|
    e.title = 'Apps for Good showcase'
    e.i_belong = true
    e.title_url = 'https://www.appsforgood.org/showcase'
    e.image_url = 'https://static.teachcomputing.org/enrichment/apps_for_good.png'
    e.body = "Design and code an app to solve a real world problem. Your students’ idea can then be submitted to a diverse range of industry experts to celebrate UK’s young people's tech innovation skills.<br><br><a href=\"#{apps_for_good_showcase_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Cisco Cyber Camps').tap do |e|
    e.title = 'Cisco Cyber Camps'
    e.i_belong = true
    e.title_url = 'https://www.teachingdigital.org/initiatives/cybercamp'
    e.image_url = 'https://static.teachcomputing.org/enrichment/cisco_cyber_camps.png'
    e.body = "Equip, inspire, and empower girls and non-binary students through this industry-aligned cybersecurity course by Cisco in partnership with Open University.<br><br><a href=\"#{cisco_cyber_camps_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Digdata').tap do |e|
    e.title = 'Digdata'
    e.i_belong = false
    e.title_url = 'https://digdata.online/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/digdata.png'
    e.body = "Help your students develop key employability skills in problem solving, data literacy, storytelling, and presentation through virtual work experience with leading UK organisations.<br><br><a href=\"#{digdata_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Teen Tech').tap do |e|
    e.title = 'Teen Tech'
    e.i_belong = false
    e.title_url = 'https://teentech.com/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/teen_tech.png'
    e.body = "Inspire your students to pursue careers in digital sectors through interactive masterclasses and festivals with leading experts in digital, science, engineering and technology industries.<br><br><a href=\"#{teen_tech_url}\">Join the webinar to find out more</a>"
  end.save
  
end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Summer term').becomes!(EnrichmentGroupings::Term).tap do |g|
  g.title = 'Summer term'
  g.term_start = DateTime.new(2024, 4, 15)
  g.term_end = DateTime.new(2024, 9, 3)
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Do your: bit').tap do |e|
    e.title = 'Do your: bit'
    e.i_belong = false
    e.title_url = 'https://microbit.org/teach/do-your-bit/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/do_your_bit.png'
    e.body = "Bring together the micro:bit and the UN’s Global Goals to provide inspiring activities for your classroom or club and an exciting digital challenge for you to run.<br><br><a href=\"#{do_your_bit_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'ARM').tap do |e|
    e.title = 'ARM'
    e.i_belong = false
    e.title_url = 'https://community.arm.com/education-hub/b/nicholas-sample/posts/asp-mooc-for-computing-teachers'
    e.image_url = 'https://static.teachcomputing.org/enrichment/arm.png'
    e.body = "Improve your learners’ engagement in Computing by introducing project-based learning (PBL), combined with Physical Computing, find out how learners can experience the thrill of innovating while also gaining and practicing the skills and knowledge they need.<br><br><a href=\"#{arm_webinar_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'FIRST® LEGO® League').tap do |e|
    e.title = 'FIRST® LEGO® League'
    e.i_belong = true
    e.title_url = 'https://education.theiet.org/first-lego-league-programmes/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/first_lego_league_iet.png'
    e.body = "Learn more about a global challenge for teams of young people to work together to explore a given topic and to design, build and program an autonomous LEGO® robot to solve a series of missions.<br><br><a href=\"#{first_lego_leauge_url}\">Join the webinar to find out more</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'CanSat').tap do |e|
    e.title = 'CanSat'
    e.i_belong = true
    e.title_url = 'https://www.stem.org.uk/esero/secondary/competitions-and-challenges/cansat'
    e.image_url = 'https://static.teachcomputing.org/enrichment/cansat.png'
    e.body = "A competition that offers a unique opportunity for students to have their first practical experience of a real space project.<br><br><a href=\"#{cansat_webinar_url}\">Join the webinar to find out more</a>"
  end.save


end.save

programme.enrichment_groupings.find_or_initialize_by(title: 'Activities throughout the year').becomes!(EnrichmentGroupings::AllYear).tap do |g|
  g.title = 'Activities throughout the year'
  g.coming_soon = false

  g.save

  g.enrichment_entries.find_or_initialize_by(title: 'Set up a STEM Club').tap do |e|
    e.title = 'Set up a STEM Club'
    e.i_belong = true
    e.title_url = 'https://www.stem.org.uk/primary/enrichment/stem-clubs'
    e.image_url = 'https://static.teachcomputing.org/enrichment/stem_clubs.png'
    e.body = "Out-of-timetable sessions that enrich and broaden the curriculum, giving young people the chance to explore subjects like science, technology, engineering and maths in less formal settings.<br><br><a href=\"#{stem_club_url}\">Find out more and get started</a>"
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Cyber Security Challenge UK').tap do |e|
    e.title = 'Cyber Security Challenge UK'
    e.i_belong = false
    e.title_url = 'https://cybersecuritychallenge.org.uk'
    e.image_url = 'https://static.teachcomputing.org/enrichment/the_cyber_trust.png'
    e.body = 'From immersive afternoon workshops and modular cyber games to local careers fairs that bring together hundreds of students at a time, Cyber Security Challenge UK aims to raise awareness of the opportunities that exist in the industry. '
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'Bebras Challenge').tap do |e|
    e.title = 'Bebras Challenge'
    e.i_belong = true
    e.title_url = 'https://www.bebras.uk/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/bebras.png'
    e.body = 'A computational thinking challenge that aims to enthuse students in all things computer science and promote computational thinking.<br><br>Part of <a href="/i-belong">I Belong: Encouraging girls into computer science</a>'
  end.save

  g.enrichment_entries.find_or_initialize_by(title: 'FIRST® LEGO® League').tap do |e|
    e.title = 'FIRST® LEGO® League'
    e.i_belong = true
    e.title_url = 'https://education.theiet.org/first-lego-league-programmes/'
    e.image_url = 'https://static.teachcomputing.org/enrichment/first_lego_leauge.png'
    e.body = 'This is a global STEM programme where young people work together to explore a given topic and to design, build and program an autonomous LEGO® robot to solve a series of missions.<br><br>Part of <a href="/i-belong">I Belong: Encouraging girls into computer science</a>'
  end.save
end.save
