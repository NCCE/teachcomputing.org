namespace :activity_seeds do
  desc "updates activity seed data"
  task update: :environment do
    Activity.find_by_slug('contribute-to-online-discussion') do |activity|
      activity.update(
                      title: 'Contribute to an online Computing at School (CAS) discussion',
                      description: 'Engage in a CAS online discussion forum or webinar, and share best practice with other teachers. Provide a link to a screenshot or the forum discussion.'
                      )
    end

    Activity.find_by_slug('attend-a-cas-community-meeting') do |activity|
      activity.update(
        description: 'Join <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" class="ncce-link">your local CAS Community </a>and attend a session. You’ll meet other teachers in your area and get to share best practice. Provide the date and event details'
      )
    end

    Activity.find_by_slug('attend-a-cas-community-meeting-secondary') do |activity|
      activity.update(
        description: 'Join <a href="https://community.computingatschool.org.uk/communities" data-event-label="CAS meeting" class="ncce-link">your local CAS Community </a>and attend a session. You’ll meet other teachers in your area and get to share best practice. Provide the date and event details'
      )
    end

    Activity.find_by_slug('review-a-resource-on-cas') do |activity|
      activity.update(
        title: 'Provide feedback on a teaching resource',
        description: 'Download a <a href="https://teachcomputing.org/curriculum/key-stage-1" data-event-label="CAS forum" class="ncce-link">KS1 lesson<a/> or <a href="https://teachcomputing.org/curriculum/key-stage-2" data-event-label="CAS forum" class="ncce-link">KS2 lesson</a> from Teach Computing Curriculum resources, or <a href="https://community.computingatschool.org.uk/resources/2616/single" data-event-label="CAS forum" class="ncce-link">a CAS teaching resource</a> and use it in your classroom. Reflect and share your feedback on how you used and adapted it.'
      )
    end

    Activity.find_by_slug( 'host-or-attend-a-barefoot-workshop') do |activity|
      activity.update(
        title: 'Organise a Barefoot Workshop at your school',
        description: 'Reach out to <a href="https://www.barefootcomputing.org/primary-computing-workshops" data-event-label="Barefoot workshop" class="ncce-link">Barefoot volunteers</a> and get them to present a workshop in your school. Provide the date and location the workshop took place.'
      )
    end

    Activity.find_by_slug('lead-a-cas-community-of-practice') do |activity|
      activity.update(
        description: 'Register as <a href="https://community.computingatschool.org.uk/hubs" data-event-label="CAS leader" class="ncce-link">a CAS Community Leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hrs per month to organise each meeting. Provide the name and location of your community.'
      )
    end

    Activity.find_by_slug('lead-a-cas-community-of-practice-secondary') do |activity|
      activity.update(
        description: 'Register as <a href="https://community.computingatschool.org.uk/hubs" data-event-label="CAS leader" class="ncce-link">a CAS Community Leader</a> and run 3 meetings per year. Low maintenance and high impact, it should only take 1 to 2 hrs per month to organise each meeting. Provide the name and location of your community.'
      )
    end

    Activity.find_by_slug('providing-additional-support') do |activity|
      activity.update(
        title: 'Give additional support to your community',
        description: 'Go beyond your day to day teaching, and support your local teachers, pupils or parents. For example: mentoring another teacher in computing, helping parents to set up and use virtual classroom technology. Provide details of the support.'
      )
    end

    Activity.find_by_slug('run-an-after-school-code-club') do |activity|
      activity.update(
        title: 'Set up and run a Code Club in your school',
        description: '<a href="https://codeclub.org/en/start-a-code-club" data-event-label="Start Code Club" class="ncce-link">Start a Code Club today</a> - free projects, resources and support for you to use with children aged 9 to 13. Already got a club at your school? Become a volunteer and help run it. Provide the name and postcode of your club.'
      )
    end
  end

end
