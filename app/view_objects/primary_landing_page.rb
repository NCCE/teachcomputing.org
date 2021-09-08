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
    if completed_primary?
      'View certificate'
    elsif enrolled_on_primary?
      'View your progress'
    else
      'Find out more'
    end
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
        image_title: 'STEM course',
        title: 'Introduction to primary computing',
        url: '/courses/CP454/introduction-to-primary-computing-remote',
        description: 'Ideal for beginners, this course covers the whole computing curriculum at an introductory level, including programming essentials using Scratch.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '5 hours',
        link_label: 'Course 1'
      },
      {
        image: 'media/images/landing-pages/stem_primary_course.png',
        image_title: 'STEM course',
        title: 'Leading primary computing',
        url: '/courses/CP456/leading-primary-computing-remote',
        description: 'Lead computing in your school with confidence, making the most of the resources and teaching staff available.',
        icon_class: 'icon-remote',
        type: 'Live remote training',
        duration: 'days vary',
        time_commitment: '10 hours',
        link_label: 'Course 2'
      },
      {
        image: 'media/images/landing-pages/5_to_11_year_olds_course.png',
        image_title: 'Programming 5 to 11 year olds course',
        title: 'Teaching Computer Systems and Networks for 5 to 11 year olds',
        url: '/courses/CO042/teaching-computing-systems-and-networks-to-5-to-11-year-olds',
        description: 'Improve your subject knowledge and develop your teaching to help young children understand the computing systems and networks around them.',
        icon_class: 'icon-online',
        type: 'Online course',
        duration: '3 weeks',
        time_commitment: '2 hours per week',
        link_label: 'Course 3'
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
        title: 'Year 2: Computing systems and networks – IT around us',
        url: '/curriculum/key-stage-1/computing-systems-and-networks-it-around-us',
        description: 'With an initial focus on IT in the home,
        learners explore how IT benefits society in places such as shops, libraries,
        and hospitals. Whilst discussing the responsible use of technology,
        and how to make smart choices when using it.',
        link_label: 'Featured unit 1'
      },
      {
        title: 'Year 3: Computing systems and networks – Connecting computers',
        url: '/curriculum/key-stage-2/computing-systems-and-networks-connecting-computers',
        description: 'Challenge your learners to develop their understanding of digital devices,
        with an initial focus on inputs, processes, and outputs.
        Start by comparing digital and non-digital devices,
        before introducing them to computer networks.',
        link_label: 'Featured unit 2'
      }
    ]
  end

  def contributing_partners
    {
      class_name: 'resource-cards',
      cards_per_row: 3,
      cards: [
        {
          image_url: 'pages/primary-teachers/barefoot.svg',
          title: I18n.t('pages.contributing-partners-cards.barefoot.title'),
          text: I18n.t('pages.contributing-partners-cards.barefoot.text'),
          link: {
            link_title: I18n.t('pages.contributing-partners-cards.barefoot.link_title'),
            link_url: 'https://www.barefootcomputing.org/',
            tracking_page: event_tracking_category,
            tracking_label: 'Barefoot'
          }
        },
        {
          image_url: 'pages/primary-teachers/code-club-card.svg',
          title: I18n.t('pages.contributing-partners-cards.code-club.title'),
          text: I18n.t('pages.contributing-partners-cards.code-club.text'),
          link: {
            link_title: I18n.t('pages.contributing-partners-cards.code-club.link_title'),
            link_url: 'https://codeclub.org/en/',
            tracking_page: event_tracking_category,
            tracking_label: 'Code club'
          }
        },
        {
          image_url: 'pages/primary-teachers/stem-card.svg',
          title: I18n.t('pages.contributing-partners-cards.stem-Ambassadors.title'),
          text: I18n.t('pages.contributing-partners-cards.stem-Ambassadors.text'),
          link: {
            link_title: I18n.t('pages.contributing-partners-cards.stem-Ambassadors.link_title'),
            link_url: 'https://www.stem.org.uk/stem-ambassadors',
            tracking_page: event_tracking_category,
            tracking_label: 'STEM Ambassadors'
          }
        }
      ]
    }
  end

  private

    def enrolled_on_primary?
      @current_user && @primary_certificate.user_enrolled?(@current_user)
    end

    def completed_primary?
      @current_user && @primary_certificate.user_completed?(@current_user)
    end
end
