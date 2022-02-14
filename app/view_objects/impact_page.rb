class ImpactPage
  class << self
    include ActionView::Helpers::UrlHelper

    def tracking_page
      'Impact'
    end

    def tracking_data(label)
      {
        event_action: 'click',
        event_category: tracking_page,
        event_label: label
      }
    end

    # Uses RelatedLinksComponent
    def related_links
      {
        links: [
          {
            link_title: I18n.t('pages.about.hero.title'),
            link_url: '/about',
            tracking_page: tracking_page,
            tracking_label: 'about'
          }
        ]
      }
    end

    # Uses ReportCardComponent
    def impact_report_card
      {
        class_name: 'impact-report-card',
        show_border: true,
        title: I18n.t('pages.impact-and-evaluation.impact_report_card.title'),
        date: I18n.t('pages.impact-and-evaluation.impact_report_card.date'),
        text: I18n.t('pages.impact-and-evaluation.impact_report_card.text'),
        bullets: [
          I18n.t('pages.impact-and-evaluation.impact_report_card.engagements.html'),
          I18n.t('pages.impact-and-evaluation.impact_report_card.cpd.html'),
          I18n.t('pages.impact-and-evaluation.impact_report_card.downloads.html'),
          I18n.t('pages.impact-and-evaluation.impact_report_card.questions.html')
        ],
        button: {
          button_title: I18n.t('pages.impact-and-evaluation.impact_report_card.button_title'),
          button_url: 'https://static.teachcomputing.org/NCCE_Impact_Report_Final.pdf',
          tracking_page: tracking_page,
          tracking_label: 'Impact report'
        }
      }
    end

    # Uses DocumentCardsComponent
    def evaluation_cards
      {
        class_name: 'evaluation-cards',
        show_border: true,
        tracking_category: tracking_page,
        cards: [
          {
            class_name: 'impact-graduates-card',
            title_link: {
              title: 'pages.impact-and-evaluation.graduates_card_2.title',
              url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort_2_Evaluation.pdf',
              tracking_label: 'CSA cohort 2'
            },
            date: 'pages.impact-and-evaluation.graduates_card_2.date',
            body: {
              text: 'pages.impact-and-evaluation.graduates_card_2.text.html',
              tokens: [
                executive_summary_link: (link_to 'our Executive Summary',
                                                 'https://static.teachcomputing.org/CSA_Graduates_Evaluation_Executive_Summary.pdf',
                                                 class: 'ncce-link', data: tracking_data('CSA 2 exec summary')
                                        )
              ]
            }
          },
          {
            class_name: 'impact-graduates-card',
            title_link: {
              title: 'pages.impact-and-evaluation.graduates_card.title',
              url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf',
              tracking_label: 'CSA cohort 1'
            },
            date: 'pages.impact-and-evaluation.graduates_card.date',
            body: {
              text: 'pages.impact-and-evaluation.graduates_card.text'
            }
          }
        ]
      }
    end

    # Uses ReportCardComponent
    def literacy_report_card
      {
        class_name: 'literacy-report-card',
        title: I18n.t('pages.impact-and-evaluation.literacy_report_card.title'),
        date: I18n.t('pages.impact-and-evaluation.literacy_report_card.date'),
        text: I18n.t('pages.impact-and-evaluation.literacy_report_card.text'),
        bullets: [
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_1.html'),
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_2.html'),
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_3.html')
        ],
        button: {
          button_title: I18n.t('pages.impact-and-evaluation.literacy_report_card.button_title'),
          button_url: 'https://static.teachcomputing.org/Programming+and+Algorithms+Report.pdf',
          tracking_page: tracking_page,
          tracking_label: 'Programming and Algorithms'
        }
      }
    end

    # Uses DocumentCardsComponent
    def curriculum_cards
      {
        class_name: 'curriculum-cards',
        tracking_category: tracking_page,
        cards: [
          {
            class_name: 'computer-systems',
            title_link: {
              title: 'pages.impact-and-evaluation.computer_systems.title',
              url: 'https://static.teachcomputing.org/Computer_Systems_%26_Networking_Report_-_Final.pdf',
              tracking_label: 'computer systems'
            },
            date: 'pages.impact-and-evaluation.computer_systems.date',
            body: {
              text: 'pages.impact-and-evaluation.computer_systems.text'
            }
          },
          {
            class_name: 'impact-literacy-card',
            title_link: {
              title: 'pages.impact-and-evaluation.literacy_card.title',
              url: 'https://raspberrypi-education.s3-eu-west-1.amazonaws.com/NCCE+Reports/Digital+Literacy+Within+the+Computing+Curriculum+(Final).pdf',
              tracking_label: 'Digital literacy'
            },
            date: 'pages.impact-and-evaluation.literacy_card.date',
            body: {
              text: 'pages.impact-and-evaluation.literacy_card.text'
            }
          },
          {
            class_name: 'impact-textbook-card',
            title_link: {
              title: 'pages.impact-and-evaluation.textbook_card.title',
              url: 'https://static.teachcomputing.org/International_Textbook_Review.pdf',
              tracking_label: 'Textbook review'
            },
            date: 'pages.impact-and-evaluation.textbook_card.date',
            body: {
              text: 'pages.impact-and-evaluation.textbook_card.text'
            }
          }
        ]
      }
    end

    # Uses BorderedCardsComponent
    def research_resource_cards
      {
        class_name: 'research-resource-cards',
        cards_per_row: 3,
        cards: [
          {
            title: I18n.t('pages.impact-and-evaluation.gender_balance_card.title'),
            text: I18n.t('pages.impact-and-evaluation.gender_balance_card.text'),
            link: {
              link_title: I18n.t('pages.impact-and-evaluation.gender_balance_card.link_title'),
              link_url: '/gender-balance',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.impact-and-evaluation.gender_balance_card.title')
            }
          },
          {
            title: I18n.t('pages.impact-and-evaluation.practitioners_card.title'),
            text: I18n.t('pages.impact-and-evaluation.practitioners_card.text'),
            link: {
              link_title: I18n.t('pages.impact-and-evaluation.practitioners_card.link_title'),
              link_url: '/subject-practitioners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.impact-and-evaluation.practitioners_card.title')
            }
          },
          {
            title: I18n.t('pages.impact-and-evaluation.pedagogy_card.title'),
            text: I18n.t('pages.impact-and-evaluation.pedagogy_card.text'),
            link: {
              link_title: I18n.t('pages.impact-and-evaluation.pedagogy_card.link_title'),
              link_url: '/pedagogy',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.impact-and-evaluation.pedagogy_card.title')
            }
          }
        ]
      }
    end

    # Uses LogoCardsComponent
    def partner_resources
      {
        class_name: 'partner-resources',
        cards_per_row: 3,
        cards: [
          {
            image_url: 'media/images/logos/stem-logo-with-bg.svg',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.stem_card.link_title'),
              title_url: 'https://www.stem.org.uk/impact-and-evaluation',
              tracking_page: tracking_page,
              tracking_label: 'STEM'
            }
          },
          {
            image_url: 'media/images/logos/rpf-logo-with-bg.svg',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.rpf_card.link_title'),
              title_url: 'https://www.raspberrypi.org/computing-education-research-online-seminars/',
              tracking_page: tracking_page,
              tracking_label: 'RPF'
            }
          },
          {
            image_url: 'media/images/logos/bcs-logo-with-bg.svg',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.bcs_card.link_title'),
              title_url: 'https://www.bcs.org/more/learned-publishing/',
              tracking_page: tracking_page,
              tracking_label: 'BCS'
            }
          }
        ]
      }
    end
  end
end
