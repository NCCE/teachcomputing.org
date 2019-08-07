require File.expand_path('../seeds/activities/action', __FILE__)
require File.expand_path('../seeds/activities/face-to-face', __FILE__)
require File.expand_path('../seeds/activities/online', __FILE__)
require File.expand_path('../seeds/activities/assessment', __FILE__)
Activity.all.each do |a|
  puts "Created activity #{a.title} (#{a})"
end
require File.expand_path('../seeds/programmes/cs_accelerator', __FILE__)
require File.expand_path('../seeds/programmes/primary', __FILE__)
require File.expand_path('../seeds/programmes/secondary', __FILE__)
