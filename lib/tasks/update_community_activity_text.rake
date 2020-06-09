task update_community_activity_text: :environment do
  activity = Activity.where(slug: 'contribute-to-online-discussion')
  activity.update(description: 'Engage in the CAS online discussion forums and webinars in a meaningful way.')
  activity = Activity.where(slug: 'review-a-resource-on-cas')
  activity.update(description: 'Head over to the CAS website to give a full review of a resource you’ve downloaded and used including how you used it in the classroom. <a href="https://community.computingatschool.org.uk/resources/2616/single">You can find CAS resources here</a>')
end
