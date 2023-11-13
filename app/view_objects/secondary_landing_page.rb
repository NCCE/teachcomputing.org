class SecondaryLandingPage
  attr_reader :cs_accelerator, :secondary_certificate

  def initialize(current_user:)
    @current_user = current_user
    @cs_accelerator = Programme.cs_accelerator
    @secondary_certificate = Programme.secondary_certificate
  end

  def meta
    {
      title: 'The essential toolkit for secondary computing teachers',
      description: 'Training and inspiration that grows your confidence, transforms your teaching and brings your lessons to life.',
      image: 'media/images/landing-pages/sec-hero.png',
      image_alt: 'Secondary Teachers - Teach Computing'
    }
  end

  def heading
    'The essential toolkit for secondary computing teachers'
  end

  def hero_text
    'Training and inspiration that grows your confidence and transforms your teaching.'
  end

  def hero_image
    'media/images/landing-pages/sec-hero.png'
  end

  def hero_class
    'lime-green-bg'
  end

  def event_tracking_category
    'Secondary teachers'
  end

  def certificates_text
    'Improve your subject knowledge and gain confidence with our nationally recognised certificates.'
  end

  def secondary?
    true
  end

  def primary?
    false
  end

  def csa_link_text
    if completed_csa?
      'View certificate'
    elsif enrolled_on_csa?
      'View your progress'
    else
      'Find out more'
    end
  end

  def csa_tracking_event
    enrolled_on_csa? ? 'CSA view progress' : 'CSA find out more'
  end

  def secondary_cert_link_text
    if completed_secondary?
      'View certificate'
    elsif enrolled_on_secondary?
      'View your progress'
    else
      'Find out more'
    end
  end

  def secondary_tracking_event
    enrolled_on_secondary? ? 'Secondary view progress' : 'Secondary find out more'
  end

  def testimonials
    [
      {
        text: '"We\'re teaching kids to use technologies that don\'t exist yet for problems that they don\'t know. It\'s going to be a completely different world when they leave school."',
        image: 'media/images/pages/careers-week/helen_brant.jpg',
        name: 'Helen Brant',
        link_target: 'https://www.teachcomputing.org/blog/music-computing',
        bio: 'Music teacher',
        tracking_event: 'Testimonial 1'
      },
      {
        text: '"As a result of the programme, I am now a computer science teacher! The programme has given me the confidence to realise the skills that I have."',
        image: 'media/images/landing-pages/nigel.png',
        name: 'Nigel Ferry',
        link_target: 'https://www.teachcomputing.org/blog/from-design-to-digital-technology/',
        bio: 'D&T to Computer Science teacher, Gateshead',
        tracking_event: 'Testimonial 2'
      },
      {
        text: '"Completing the Computer Science Accelerator has honestly changed my career. It has given me the confidence to do so many new things."',
        image: 'media/images/landing-pages/annie.png',
        name: 'Annie Cuffe Davies',
        link_target: 'https://www.teachcomputing.org/blog/how-cpd-changed-my-career/',
        bio: 'ICT and Computing teacher, London',
        tracking_event: 'Testimonial 3'
      }
    ]
  end

  def courses_intro
    'Begin your computing journey, develop your understanding of a specific topic, or improve your pedagogical practice.'
  end

  def courses
    [
      {
        image: 'media/images/landing-pages/stem_course.png',
        image_title: 'Python programming constructs: sequencing, selection & iteration for OCR specification',
        title: 'Python programming constructs: sequencing, selection & iteration for OCR specification',
        url: '/courses/CP423A/python-programming-constructs-sequencing-selection-iteration-for-ocr-specification',
        description: "Learn how to write code to input, process and output data, and how to manipulate data stored in variables. Also available for <a href='/courses/CP423B/python-programming-constructs-sequencing-selection-iteration-for-aqa-specification'>AQA</a> and <a href='/courses/CP423C/python-programming-constructs-sequencing-selection-iteration-for-pearson-specification'>Pearson</a> specifications.",
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'Days vary',
        time_commitment: '6 hours',
        event_label: 'Course 1'
      },
      {
        image: 'media/images/landing-pages/lp-sec-crs-2.png',
        image_title: 'Supporting GCSE computer science students at grades 1 to 3',
        title: 'Supporting GCSE computer science students at grades 1 to 3',
        url: '/courses/CP478/supporting-gcse-computer-science-students-at-grades-1-3',
        description: 'This evidence-based CPD explores how to improve attainment in Computer Science for students working towards grades 1 to 3.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'Days vary',
        time_commitment: '6 hours',
        event_label: 'Course 2'
      },
      {
        image: 'media/images/landing-pages/studying.png',
        image_title: 'Impact of Technology: How To Lead Classroom Discussions',
        title: 'Impact of Technology: How To Lead Classroom Discussions',
        url: '/courses/CO215/impact-of-technology-how-to-lead-classroom-discussions',
        description: 'Explore the ethical, legal, cultural, and environmental concerns surrounding computer science.',
        icon_class: 'icon-online',
        type: 'Online course',
        time_commitment: 'Approximately 8 hours of self-study',
        event_label: 'Course 3'
      }
    ]
  end

  def resources_text
    'Free teaching resources for key stage 3 and 4. Everything you need to
      teach computing including lesson plans, slides, assessments and activities.'
  end

  def resources
    [
      {
        title: 'GCSE: Data representations',
        url: '/curriculum/key-stage-4/data-representations',
        description: 'This unit has been re-written based on your feedback, to have more scaffolding,
          unique lesson activities and content on data compression. For example the escape room activity in lesson 9,
          the image manipulation activity in lesson 10 and the Huffman coding activities in lesson 17.',
        event_label: 'Featured unit 1',
        updated_at: 'Updated October 2021'
      },
      {
        title: 'Year 7: Networks from semaphores to the Internet',
        url: '/curriculum/key-stage-3/networks-from-semaphores-to-the-internet',
        description: 'This unit begins by defining a network and addressing the
        benefits and importance of computer networks, before covering how data
        is transmitted across networks using protocols.',
        event_label: 'Featured unit 2',
        updated_at: 'Updated August 2021'
      }
    ]
  end

  private

    def enrolled_on_csa?
      @current_user && @cs_accelerator.user_enrolled?(@current_user)
    end

    def completed_csa?
      @current_user && @cs_accelerator.user_completed?(@current_user)
    end

    def enrolled_on_secondary?
      @current_user && @secondary_certificate.user_enrolled?(@current_user)
    end

    def completed_secondary?
      @current_user && @secondary_certificate.user_completed?(@current_user)
    end
end
