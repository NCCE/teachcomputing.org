namespace :activities do
  task seed: :environment do

    Activity.find_or_create_by(slug: 'downloaded-diagnostic-tool') do |activity|
      activity.title = 'Downloaded diagnostic tool'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'action'
    end

    Activity.find_or_create_by(slug: 'teaching-physical-computing-with-raspberry-pi-and-python') do |activity|
      activity.title = 'Teaching Physical Computing with Raspberry Pi and Python'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

    Activity.find_or_create_by(slug: 'how-computers-work-demystifying-computation') do |activity|
      activity.title = 'How Computers Work: Demystifying Computation'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

    Activity.find_or_create_by(slug: 'programming-101-an-introduction-to-python-for-educators') do |activity|
      activity.title = 'Programming 101: An Introduction to Python for Educators'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

    Activity.find_or_create_by(slug: 'programming-102-think-like-a-computer-scientist') do |activity|
      activity.title = 'Programming 102: Think like a Computer Scientist'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

    Activity.find_or_create_by(slug: 'representing-data-with-images-and-sound-bringing-data-to-life') do |activity|
      activity.title = 'Representing Data with Images and Sound: Bringing Data to Life'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

    Activity.find_or_create_by(slug: 'object-oriented-programming-in-python-create-your-own-adventure-game') do |activity|
      activity.title = 'Object-oriented Programming in Python: Create Your Own Adventure Game'
      activity.credit = 0
      activity.slug = activity.title.parameterize
      activity.category = 'cpd'
    end

  end
end
