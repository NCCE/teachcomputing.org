namespace :activities do
  task seed: :environment do
    
    Activity.create(
      title: 'Downloaded diagnostic tool',
      credit: 0,
      slug: 'downloaded-diagnostic-tool',
      category: 'action',
    )

    Activity.create(
      title: 'Teaching Physical Computing with Raspberry Pi and Python',
      credit: 0,
      slug: 'teaching-physical-computing-with-raspberry-pi-and-python',
      category: 'cpd',
    )

    Activity.create(
      title: 'How Computers Work: Demystifying Computation',
      credit: 0,
      slug: 'how-computers-work-demystifying-computation',
      category: 'cpd',
    )

    Activity.create(
      title: 'Programming 101: An Introduction to Python for Educators',
      credit: 0,
      slug: 'programming-101-an-introduction-to-python-for-educators',
      category: 'cpd',
    )

    Activity.create(
      title: 'Programming 102: Think like a Computer Scientist',
      credit: 0,
      slug: 'programming-102-think-like-a-computer-scientist',
      category: 'cpd',
    )

    Activity.create(
      title: 'Representing Data with Images and Sound: Bringing Data to Life',
      credit: 0,
      slug: 'representing-data-with-images-and-sound-bringing-data-to-life',
      category: 'cpd',
    )
  end
end
