class ImpactPage
  class << self
    def tracking_page
      'Impact'
    end

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

    def evaluation_cards
      {
        class_name: 'evaluation-cards',
        show_border: true,
        cards: [
          {
            class_name: 'impact-graduates-card',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.graduates_card_2.title'),
              title_url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf',
              tracking_page: tracking_page,
              tracking_label: 'CSA cohort 2'
            },
            date: I18n.t('pages.impact-and-evaluation.graduates_card_2.date'),
            text: I18n.t('pages.impact-and-evaluation.graduates_card_2.text')
          },
          {
            class_name: 'impact-graduates-card',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.graduates_card.title'),
              title_url: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf',
              tracking_page: tracking_page,
              tracking_label: 'CSA cohort 1'
            },
            date: I18n.t('pages.impact-and-evaluation.graduates_card.date'),
            text: I18n.t('pages.impact-and-evaluation.graduates_card.text')
          }
        ]
      }
    end

    def literacy_report_card
      {
        class_name: 'literacy-report-card',
        title: I18n.t('pages.impact-and-evaluation.literacy_report_card.title'),
        date: I18n.t('pages.impact-and-evaluation.literacy_report_card.date'),
        text: I18n.t('pages.impact-and-evaluation.literacy_report_card.text'),
        bullets: [
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_1.html'),
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_2.html'),
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_3.html'),
          I18n.t('pages.impact-and-evaluation.literacy_report_card.item_4.html')
        ],
        button: {
          button_title: I18n.t('pages.impact-and-evaluation.literacy_report_card.button_title'),
          button_url: 'https://raspberrypi-education.s3-eu-west-1.amazonaws.com/NCCE+Reports/Digital+Literacy+Within+the+Computing+Curriculum+(Final).pdf',
          tracking_page: tracking_page,
          tracking_label: 'Digital literacy'
        }
      }
    end

    def curriculum_cards
      {
        class_name: 'curriculum-cards',
        cards: [
          {
            class_name: 'impact-textbook-card',
            title_link: {
              title: I18n.t('pages.impact-and-evaluation.textbook_card.title'),
              title_url: 'https://static.teachcomputing.org/International_Textbook_Review.pdf',
              tracking_page: tracking_page,
              tracking_label: 'Textbook review'
            },
            date: I18n.t('pages.impact-and-evaluation.textbook_card.date'),
            text: I18n.t('pages.impact-and-evaluation.textbook_card.text')
          }
        ]
      }
    end

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
