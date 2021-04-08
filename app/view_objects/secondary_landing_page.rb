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
    'tapestry-bg'
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
    enrolled_on_csa? ? 'View your progress' : 'Find out more'
  end

  def csa_tracking_event
    enrolled_on_csa? ? 'CSA view progress' : 'CSA find out more'
  end

  def secondary_cert_link_text
    enrolled_on_secondary? ? 'View your progress' : 'Find out more'
  end

  def secondary_tracking_event
    enrolled_on_secondary? ? 'Secondary view progress' : 'Secondary find out more'
  end

  def testimonials
    [
      {
        text: '“The online courses let me go through the content at my own pace, while the face to face gave me more hands-on experience with practical programming.”',
        image: 'media/images/landing-pages/kasim.png',
        name: 'Kasim Rashid',
        link_target: 'https://blog.teachcomputing.org/getting-with-the-programming/',
        bio: 'Maths and Computer Science teacher, London',
        tracking_event: 'Testimonial 1'
      },
      {
        text: '“As a result of the programme, I am now a computer science teacher! The programme has given me the confidence to realise the skills that I have.”',
        image: 'media/images/landing-pages/nigel.png',
        name: 'Nigel Ferry',
        link_target: 'https://blog.teachcomputing.org/from-design-to-digital-technology/',
        bio: 'D&T to Computer Science teacher, Gateshead',
        tracking_event: 'Testimonial 2'
      },
      {
        text: '“Completing the Computer Science Accelerator has honestly changed my career. It has given me the confidence to do so many new things.”',
        image: 'media/images/anne-cuffe-davies.png',
        name: 'Annie Cuffe Davies',
        link_target: 'https://blog.teachcomputing.org/how-cpd-changed-my-career/',
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
        image: 'media/images/landing-pages/lp-sec-crs-1.png',
        title: 'Higher attainment in GCSE computer science',
        url: '/courses/CP439/higher-attainment-in-gcse-computer-science-meeting-the-challenges-of-the-exams-remote',
        description: 'Explore how to improve attainment in GCSE computer science, look at how students should tackle exam questions, retrieval practice and interleaving, and progression from KS3 to KS4.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '5 hours'
      },
      {
        image: 'media/images/landing-pages/lp-sec-crs-2.png',
        title: 'Teaching GCSE computer science: improving student engagement',
        url: '/courses/CP447/teaching-gcse-computer-science-improving-student-engagement-remote',
        description: 'Improve student engagement in your GCSE computer science lessons by developing your classroom pedagogy.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '6 hours'
      },
      {
        image: 'media/images/landing-pages/lp-sec-crs-3.png',
        title: 'Impact of Technology: How To Lead Classroom Discussions',
        url: '/courses/CO215/impact-of-technology-how-to-lead-classroom-discussions',
        description: 'You will explore the ethical, legal, cultural, and environmental concerns surrounding computer science.',
        icon_class: 'icon-online',
        type: 'Online course',
        duration: '3 weeks',
        time_commitment: '2 hours per week'
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
        title: 'Year 7: Networks from semaphores to the Internet',
        url: '/curriculum/key-stage-3/networks-from-semaphores-to-the-internet',
        description: 'This unit begins by defining a network and addressing the
          benefits and importance of computer networks, before covering how data
          is transmitted across networks using protocols.'
      },
      {
        title: 'KS4 GCSE: Data representations',
        url: '/curriculum/key-stage-4/data-representations',
        description: 'This unit will help your learners to understand binary
          and hexadecimal numbering systems, how to convert between bases,
          coding systems and how text, images, and sound are represented in computers.'
      }
    ]
  end

  private

    def enrolled_on_csa?
      @current_user && @cs_accelerator.user_enrolled?(@current_user)
    end

    def enrolled_on_secondary?
      @current_user && @secondary_certificate.user_enrolled?(@current_user)
    end
end
