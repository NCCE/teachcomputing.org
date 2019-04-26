namespace :programmes do
  task cs_accelerator: :environment do
    cs_accelerator = Programme.find_or_create_by(slug: 'cs-accelerator') do |programme|
      programme.title = 'CS Accelerator'
      programme.slug = 'cs-accelerator'
      programme.description = 'If you’re a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you.'
    end

    puts "Programme: #{cs_accelerator}"

    slugs = %w[
      algorithms-in-gcse-computer-science
      data-and-computer-systems-in-gcse-computer-science
      networks-and-cyber-security-in-gcse-computer-science
      python-programming-essentials-for-gcse-computer-science
      teaching-physical-computing-with-raspberry-pi-and-python
      how-computers-work-demystifying-computation
      programming-101-an-introduction-to-python-for-educators
      programming-102-think-like-a-computer-scientist
      representing-data-with-images-and-sound-bringing-data-to-life
      object-oriented-programming-in-python-create-your-own-adventure-game
      an-introduction-to-computer-networking-for-teachers
      understanding-maths-and-logic-in-computer-science
      understanding-computer-systems
    ]

    slugs.each do |slug|
      activity = Activity.find_by(slug: slug)
      unless activity.programmes.include?(cs_accelerator)
        puts "Adding: #{activity.title} to programme: #{cs_accelerator.slug}"
        activity.programmes.push(cs_accelerator)
        activity.save
      end
    end
  end
end
