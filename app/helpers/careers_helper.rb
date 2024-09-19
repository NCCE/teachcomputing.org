module CareersHelper
  def careers_support_testimonal_data
    [
      {
        text: "“It was amazing to be able to create whatever you wanted just by planning it out and learning how to execute it using code. If I could do that for a game, I thought I could do that for other things in life too.”",
        image: "media/images/pages/careers-support/mikaela.png",
        name: "Mikaela",
        link_target: "https://isaaccomputerscience.org/pages/cs_journeys_mikaela",
        bio: "Embedded Software Engineer<br /><br />#{link_to "Read Mikaela's story", "https://isaaccomputerscience.org/pages/cs_journeys_mikaela",
          class: "ncce-link ncce-link--on-dark axe-skip-a11y-test",
          data: {
            event_action: "click",
            event_category: "",
            event_label: ""
          }}".html_safe
      },
      {
        text: "“I become fascinated by data bias and the potential power AI has. I wanted to be a part of this and ensure that such technology is used to help others and shape our world for the better.”",
        image: "media/images/pages/careers-support/tori.png",
        name: "Tori",
        link_target: "https://isaaccomputerscience.org/pages/cs_journeys_tori",
        bio: "Computer Science and AI student<br /><br />#{link_to "Read Tori's story", "https://isaaccomputerscience.org/pages/cs_journeys_tori",
          class: "ncce-link ncce-link--on-dark axe-skip-a11y-test",
          data: {
            event_action: "click",
            event_category: "",
            event_label: ""
          }}".html_safe
      }
    ]
  end

  def careers_support_resource_cards
    [
      {
        title: "GCSE options guide",
        title_link: "https://static.teachcomputing.org/I+Belong+-+GCSE+Options+Resource.pdf",
        text: "The options process is an important stage in a young person’s journey through education. Our guide will help you explore how you present GCSE options guidance to encourage more students, particularly girls, to consider choosing it as one of their option subjects.",
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_3.svg",
          "media/images/pages/careers-support/benchmark_4.svg",
          "media/images/pages/careers-support/benchmark_8.svg"
        ]
      },
      {
        title: "Teach Computing Curriculum",
        title_link: curriculum_key_stages_path,
        text: "Our Teach Computing Curriculum includes many references to careers in computing. You can also find further advice on including careers advice in lessons in our #{link_to "I Belong programme", about_i_belong_path} handbook.".html_safe,
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_4.svg"
        ]
      },
      {
        title: "Bring real-life role models into the classroom<i class='icon-link-external in-link'></i>".html_safe,
        title_link: "https://www.stem.org.uk/stem-ambassadors/computing-ambassadors",
        text: "Computing Ambassadors are volunteers from a wide range of industries who can connect computing lessons to real-world careers. A free resource for schools, they help to bring the curriculum to life and inspire more young people to choose a career in computing.",
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_5.svg",
          "media/images/pages/careers-support/benchmark_6.svg"
        ]
      },
      {
        title: "I Belong: encouraging girls into computer science",
        title_link: about_i_belong_path,
        text: "Girls are consistently outnumbered by boys in computer science, starting with the drop-out at transition from primary to secondary. The I Belong programme supports schools to understand the barriers to girls’ participation, ways to overcome them, and helps educators sustain pupils' enthusiasm for the subject.",
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_3.svg"
        ],
        class_name: "benchmark-bordered-card--i-belong"
      },
      {
        title: "Computing Quality Framework<i class='icon-link-external in-link'></i>".html_safe,
        title_link: "https://computingqualityframework.org/",
        text: "Our framework is free to use and designed to help schools review and plan how they teach the computing curriculum. Dimension six  covers careers education, including advice such as ensuring the curriculum is culturally relevant and addressing the issue of gender balance in computing.",
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_1.svg",
          "media/images/pages/careers-support/benchmark_5.svg",
          "media/images/pages/careers-support/benchmark_6.svg",
          "media/images/pages/careers-support/benchmark_7.svg"
        ]
      },
      {
        title: "Guidance for you",
        title_link: hubs_path,
        text: "We recommend conducting a 1:1 interview with every student, ensuring you provide quality guidance about STEM pathways using all the advice above.<br /><br />We are here to help, and you can contact your #{link_to "local Computing Hub", hubs_path} for further support and guidance for your school.".html_safe,
        benchmark_icons: [
          "media/images/pages/careers-support/benchmark_8.svg"
        ]
      }
    ]
  end
end
