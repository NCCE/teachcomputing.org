class SecondaryLandingPage
  # attr_reader :current_user

  def initialize(current_user:)
    @current_user = current_user
    @cs_accelerator = Programme.cs_accelerator
    @secondary_certificate = Programme.secondary_certificate
  end

  def certificates_text
    'Improve your subject knowledge and gain confidence with our nationally recognised certificates.'
  end

  def secondary
    true
  end

  def csa_link_text
    enrolled_on_csa? ? 'View your progress' : 'Find out more'
  end

  def secondary_cert_link_text
    enrolled_on_secondary? ? 'View your progress' : 'Find out more'
  end

  def testimonials
    [
      {
        text: '“The online courses let me go through the content at my own pace, while the face to face gave me more hands-on experience with practical programming.”',
        image: 'media/images/secondary-teachers/kasim.png',
        name: 'Kasim Rashid',
        link_target: 'https://blog.teachcomputing.org/getting-with-the-programming/',
        bio: 'Maths and Computer Science teacher, London'
      },
      {
        text: '“As a result of the programme, I am now a computer science teacher! The programme has given me the confidence to realise the skills that I have.”',
        image: 'media/images/secondary-teachers/nigel.png',
        name: 'Nigel Ferry',
        link_target: 'https://blog.teachcomputing.org/from-design-to-digital-technology/',
        bio: 'D&T to Computer Science teacher, Gateshead'
      },
      {
        text: '“Completing the Computer Science Accelerator has honestly changed my career. It has given me the confidence to do so many new things.”',
        image: 'media/images/secondary-teachers/annie.png',
        name: 'Annie Cuffe Davies',
        link_target: 'https://blog.teachcomputing.org/how-cpd-changed-my-career/',
        bio: 'ICT and Computing teacher, London'
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
