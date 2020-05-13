task set_self_certifiable_false: :environment do
  responses = Activity.where(category: Activity::ONLINE_CATEGORY, self_certifiable: true)
  puts "Will update #{responses.length} matching activities"
  responses.update_all(self_certifiable: false)
end
