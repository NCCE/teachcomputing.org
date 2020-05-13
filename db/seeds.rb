require File.expand_path('../seeds/programmes/cs_accelerator', __FILE__)
require File.expand_path('../seeds/programmes/primary-certificate', __FILE__)
# require File.expand_path('../seeds/programmes/secondary-certificate', __FILE__)

require File.expand_path('../seeds/activities/action', __FILE__)
require File.expand_path('../seeds/activities/diagnostic', __FILE__)
require File.expand_path('../seeds/activities/face-to-face', __FILE__)
require File.expand_path('../seeds/activities/online', __FILE__)
require File.expand_path('../seeds/activities/assessment', __FILE__)
require File.expand_path('../seeds/activities/community', __FILE__)

Programme.all.each do |p|
  puts "\nProgramme: #{p.title} activities:\n\n"
  p.activities.each do |a|
    puts "#{a.title} (category: #{a.category})"
  end
  puts "\n"
end
