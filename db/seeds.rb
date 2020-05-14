require_relative './seeds/programmes/cs_accelerator'
require_relative './seeds/programmes/primary-certificate'
# require_relative './seeds/programmes/secondary-certificate'

require_relative './seeds/activities/action'
require_relative './seeds/activities/diagnostic'
require_relative './seeds/activities/face-to-face'
require_relative './seeds/activities/online'
require_relative './seeds/activities/assessment'
require_relative './seeds/activities/community'

Programme.all.each do |p|
  puts "\nProgramme: #{p.title} activities:\n\n"
  p.activities.each do |a|
    puts "#{a.title} (category: #{a.category})"
  end
  puts "\n"
end
