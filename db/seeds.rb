require_relative './seeds/programmes/cs_accelerator'
require_relative './seeds/programmes/primary-certificate'
require_relative './seeds/programmes/secondary-certificate'
require_relative './seeds/programmes/i_belong_certificate'

require_relative './seeds/activities/action'
require_relative './seeds/activities/diagnostic'
require_relative './seeds/activities/stem_learning'
require_relative './seeds/activities/future_learn'
require_relative './seeds/activities/mylearning'
require_relative './seeds/activities/assessment'
require_relative './seeds/activities/community'

if ENV['PREPROD_ACHIEVER_COURSES'] == 'on'
  require_relative './seeds/activities/preprod_achiever_courses'
end

require_relative './seeds/programme_activity_groupings_helper'
require_relative './seeds/programme_activity_groupings/primary_certificate'
require_relative './seeds/programme_activity_groupings/secondary_certificate'
require_relative './seeds/programme_activity_groupings/i_belong_certificate'

require_relative './seeds/pathways/cs_accelerator'
require_relative './seeds/pathways/primary_certificate'

require_relative './seeds/admin/authorisers'

Programme.all.each do |p|
  puts "\nProgramme: #{p.title} activities:\n\n"
  p.activities.each do |a|
    puts "#{a.title} (category: #{a.category})"
  end
  puts "\n"
end
