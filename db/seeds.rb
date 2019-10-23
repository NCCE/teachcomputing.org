require File.expand_path('../seeds/activities/action', __FILE__)
require File.expand_path('../seeds/activities/diagnostic', __FILE__)
require File.expand_path('../seeds/activities/face-to-face', __FILE__)
require File.expand_path('../seeds/activities/online', __FILE__)
require File.expand_path('../seeds/activities/assessment', __FILE__)
# Glen commented out until these activities have finalised info
require File.expand_path('../seeds/activities/community', __FILE__)
Activity.all.each do |a|
  puts "Created activity #{a.title} (#{a})"
end
require File.expand_path('../seeds/programmes/cs_accelerator', __FILE__)
# Glen commented out until these programmes have finalised info
require File.expand_path('../seeds/programmes/primary-certificate', __FILE__)
# require File.expand_path('../seeds/programmes/secondary-certificate', __FILE__)
