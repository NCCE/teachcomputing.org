module EnrolmentHelper
  def non_gcse_card_data
    [
      {
        title: "Building confidence",
        text: "Our <a href='/courses' class='govuk-link'>high-quality CPD</a> and nationally accredited certification can help you feel more confident and advance your skills to teach computing at secondary. By <a href='/secondary-certification' class='govuk-link'>developing your subject knowledge</a> and classroom practice, you will help build student understanding and be able to tackle misconceptions.".html_safe
      },
      {
        title: "Improving capacity",
        text: "Created by subject experts using the latest pedagogical research and teacher feedback, our <a href='/curriculum' class='govuk-link'>free curriculum resources</a> can help you tackle the workload effectively. The
        time-saving learning materials from <a href='/isaac-computer-science' class='govuk-link'>Isaac Computer Science</a> will also make marking, homework and monitoring students’ progress easier.".html_safe
      },
      {
        title: "Ensuring sustainability",
        text: "We will support you to take important steps in ensuring sustainable development of your school’s computing department. We can help you improve diversity and gender balance in computing as well as identify areas of your provision to focus on in more detail through the <a href='https://computingqualityframework.org/' class='govuk-link'>Computing Quality Framework</a>.".html_safe
      }
    ].map! do |card|
      card.merge!(button: :blank)
    end
  end

  def non_gcse_card_data_2
    find_out_more = "Find out more"

    [
      {
        title: "KS3 & GCSE Subject Knowledge certificate",
        text: "Improve your knowledge with our high-quality CPD and demonstrate commitment by gaining a nationally accredited certificate.",
        image_url: "media/images/certificate/bcs-logo.svg",
        button: :white,
        top_color: :green,
        links: [
          {
            link_url: "/certificate/subject-knowledge",
            link_title: find_out_more
          }
        ]
      },
      {
        title: "I Belong: encouraging girls into computer science",
        text: "Inspire more girls to choose computer science, improving gender balance and increasing attainment.",
        image_url: "media/images/pages/i-belong/i_belong_flag.svg",
        button: :white,
        top_color: :orange,
        links: [
          {
            link_url: "/i-belong",
            link_title: find_out_more
          }
        ]
      },
      {
        title: "Isaac Computer Science",
        text: "With resources covering all exam board specifications, save time on marking, homework and revision support with our free online textbook.",
        image_url: "media/images/logos/isaac-logo-small.svg",
        button: :white,
        top_color: :yellow,
        links: [
          {
            link_url: "https://isaaccomputerscience.org/",
            link_title: find_out_more
          }
        ]
      }
    ]
  end

  def non_gcse_testimonials_data
    [
      {
        text: "“Teachers played a pivotal role in fostering my interest by providing guidance and support in navigating the complexities of computing studies, highlighting the variety of opportunities which are available in the field.”",
        image: "media/images/pages/non-gcse/tori.png",
        name: "Tori",
        link_target: "",
        bio: "Computer Science student at the University of Essex"
      },
      {
        text: "“Having all the training and resources on offer has enabled me to gain a good understanding of different concepts, and the skills that children need to build on to become better computer scientists.”",
        image: "media/images/pages/non-gcse/richard.png",
        name: "Richard Berryman",
        link_target: "",
        bio: "Computing Lead"
      }
    ]
  end
end
