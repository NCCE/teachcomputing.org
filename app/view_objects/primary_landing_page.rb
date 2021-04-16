class PrimaryLandingPage
  attr_reader :primary_certificate

  def initialize(current_user:)
    @current_user = current_user
    @primary_certificate = Programme.primary_certificate
  end

  def meta
    {
      title: 'Inspiration and support for teaching primary computing',
      description: 'Training and enrichment to help you teach and lead the computing curriculum and improve learning across your school.',
      image: 'media/images/landing-pages/pri-hero.png',
      image_alt: 'Primary Teachers - Teach Computing'
    }
  end

  def heading
    'The essential toolkit for primary computing teachers'
  end

  def hero_text
    'Training and enrichment to help you teach and lead the computing curriculum and improve learning across your school.'
  end

  def hero_image
    'media/images/landing-pages/pri-hero.png'
  end

  def hero_class
    'jaffa-bg'
  end

  def event_tracking_category
    'Primary teachers'
  end

  def certificates_text
    'Designed for primary teachers from all backgrounds who want to improve their knowledge and teaching practice.'
  end

  def secondary?
    false
  end

  def primary?
    true
  end

  def primary_cert_link_text
    enrolled_on_primary? ? 'View your progress' : 'Find out more'
  end

  def primary_tracking_event
    enrolled_on_primary? ? 'Primary view progress' : 'Primary find out more'
  end

  def testimonials
    nil
  end

  def courses_intro
    'Develop your understanding of a specific topic, your pedagogical practice or get help as a beginner.'
  end

  def courses
    [
      {
        image: 'media/images/landing-pages/lp-pri-crs-1.png',
        title: 'Introduction to primary computing',
        url: '/courses/CP454/introduction-to-primary-computing-remote',
        description: 'Ideal for beginners, this course covers the whole computing curriculum at an introductory level, including programming essentials using Scratch.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '5 hours'
      },
      {
        image: 'media/images/landing-pages/lp-pri-crs-2.png',
        title: 'Primary programming and algorithms',
        url: '/courses/CP455/primary-programming-and-algorithms-remote',
        description: 'Be prepared to teach algorithms and programming to all ages of children, helping them develop their understanding through effective pedagogy.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '5 hours'
      },
      {
        image: 'media/images/landing-pages/lp-pri-crs-3.png',
        title: 'Programming pedagogy in primary schools: developing computing teaching',
        url: '/courses/CO020/programming-pedagogy-in-primary-schools-developing-computing-teaching',
        description: 'Investigate a range of pedagogical approaches for teaching programming to primary pupils',
        icon_class: 'icon-online',
        type: 'Online course',
        duration: '4 weeks',
        time_commitment: '2 hours per week'
      }
    ]
  end

  def resources_text
    'Our free resources provide everything you need to teach computing at key stage 1 and 2.
    They include curriculum maps, lesson plans, slides, assessments and activities.'
  end

  def resources
    [
      {
        title: 'Year 2: Creating media - Digital photography',
        url: '/curriculum/key-stage-1/creating-media-digital-photography',
        description: 'Learners will look at how different devices can be used to take
        photographs and will capture, edit, and improve photos.
        They will use this knowledge to recognise that images they see may not be real.'
      },
      {
        title: 'Year 4: Programming A – Repetition in shapes',
        url: '/curriculum/key-stage-2/programming-a-repetition-in-shapes',
        description: 'This unit is the first of the two programming units in Year 4,
        and looks at repetition and loops within programming. Pupils will create programs by
        planning, modifying, and testing commands to create shapes and patterns.'
      }
    ]
  end

  private

    def enrolled_on_primary?
      @current_user && @primary_certificate.user_enrolled?(@current_user)
    end
end
