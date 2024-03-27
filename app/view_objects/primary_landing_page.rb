class PrimaryLandingPage
  attr_reader :primary_certificate

  def initialize(current_user:)
    @current_user = current_user
    @primary_certificate = Programme.primary_certificate
  end

  def meta
    {
      title: "Inspiration and support for teaching primary computing",
      description: "Training and enrichment to help you teach and lead the computing curriculum and improve learning across your school.",
      image: "media/images/landing-pages/pri-hero.png",
      image_alt: "Primary Teachers - Teach Computing"
    }
  end

  def heading
    "The essential toolkit for primary computing teachers"
  end

  def hero_text
    "Training and enrichment to help you teach and lead the computing curriculum and improve learning across your school."
  end

  def hero_image
    "media/images/landing-pages/pri-hero.png"
  end

  def hero_class
    "lime-green-bg"
  end

  def event_tracking_category
    "Primary teachers"
  end

  def certificates_text
    "Designed for primary teachers from all backgrounds who want to improve their knowledge and teaching practice."
  end

  def secondary?
    false
  end

  def primary?
    true
  end

  def primary_cert_link_text
    if completed_primary?
      "View certificate"
    elsif enrolled_on_primary?
      "View your progress"
    else
      "Find out more"
    end
  end

  def primary_tracking_event
    enrolled_on_primary? ? "Primary view progress" : "Primary find out more"
  end

  def testimonials
    nil
  end

  def courses_intro
    "Develop your understanding of a specific topic, your pedagogical practice or get help as a beginner."
  end

  def courses
    [
      {
        image: "media/images/landing-pages/lp-pri-crs-1.png",
        image_title: "STEM course",
        title: "Introduction to primary computing",
        url: "/courses/CP454/introduction-to-primary-computing-remote",
        description: "Ideal for beginners, this course covers the whole computing curriculum at an introductory level, including programming essentials using Scratch.",
        icon_class: "icon-remote",
        type: "Live remote training",
        duration: "days vary",
        time_commitment: "5 hours",
        event_label: "Course 1"
      },
      {
        image: "media/images/landing-pages/stem_primary_course.png",
        image_title: "STEM course",
        title: "Leading primary computing",
        url: "/courses/CP456/leading-primary-computing-remote",
        description: "Lead computing in your school with confidence, making the most of the resources and teaching staff available.",
        icon_class: "icon-remote",
        type: "Live remote training",
        duration: "days vary",
        time_commitment: "10 hours",
        event_label: "Course 2"
      },
      {
        image: "media/images/landing-pages/5_to_11_year_olds_course.png",
        image_title: "Programming 5 to 11 year olds course",
        title: "Teaching Programming to 5- to 11-year-olds",
        url: "/courses/CO041/teaching-programming-to-5-to-11-year-olds",
        description: "Build your subject knowledge and develop your skills in teaching programming.",
        icon_class: "icon-online",
        type: "Online course",
        time_commitment: "Approximately 8 hours of self-study",
        event_label: "Course 3"
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
        title: "Year 2: Programming A – Robot algorithms",
        url: "/curriculum/key-stage-1/programming-a-robot-algorithms",
        description: "Learners will use logical reasoning to predict the outcome of sequences of commands and test their prediction with floor robots. They will then create different algorithms to reach the same outcome.",
        event_label: "Featured unit 1",
        updated_at: "Featured unit"
      },
      {
        title: "Year 5: Programming A – Selection in physical computing",
        url: "/curriculum/key-stage-2/programming-a-selection-in-physical-computing",
        description: "Using Crumbles, learners will control physical components such as LEDs and motors. They will create programs which use selection to respond to inputs and explore program flow.",
        event_label: "Featured unit 2",
        updated_at: "Featured unit"
      }
    ]
  end

  def contributing_partners
    {
      class_name: "resource-cards",
      cards_per_row: 3,
      cards: [
        {
          image_url: "pages/primary-teachers/barefoot.svg",
          title: I18n.t("pages.contributing-partners-cards.barefoot.title"),
          text: I18n.t("pages.contributing-partners-cards.barefoot.text"),
          link: {
            link_title: I18n.t("pages.contributing-partners-cards.barefoot.link_title"),
            link_url: "https://www.barefootcomputing.org/",
            tracking_page: event_tracking_category,
            tracking_label: "Barefoot"
          }
        },
        {
          image_url: "pages/primary-teachers/code-club-card.svg",
          title: I18n.t("pages.contributing-partners-cards.code-club.title"),
          text: I18n.t("pages.contributing-partners-cards.code-club.text"),
          link: {
            link_title: I18n.t("pages.contributing-partners-cards.code-club.link_title"),
            link_url: "https://codeclub.org/en/",
            tracking_page: event_tracking_category,
            tracking_label: "Code club"
          }
        },
        {
          image_url: "pages/primary-teachers/stem-card.svg",
          title: I18n.t("pages.contributing-partners-cards.stem-Ambassadors.title"),
          text: I18n.t("pages.contributing-partners-cards.stem-Ambassadors.text"),
          link: {
            link_title: I18n.t("pages.contributing-partners-cards.stem-Ambassadors.link_title"),
            link_url: "https://www.stem.org.uk/stem-ambassadors",
            tracking_page: event_tracking_category,
            tracking_label: "STEM Ambassadors"
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
