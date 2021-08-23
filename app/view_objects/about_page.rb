class AboutPage
  class << self
    def tracking_page
      'About'
    end

    def hero
      {
        class_name: 'dixie-bg',
        title: I18n.t('pages.about.hero.title'),
        text: I18n.t('pages.about.hero.text.html'),
        image: {
          url: 'media/images/pages/about/ncce_staff.jpg',
          title: I18n.t('pages.about.hero.image_title')
        }
      }
    end

    def resource_cards
      {
        class_name: 'resource-cards',
        cards_per_row: 3,
        cards: [
          {
            image_url: 'media/images/logos/tc-logo-with-bg.svg',
            title: I18n.t('pages.about.tc_card.title'),
            text: I18n.t('pages.about.tc_card.text'),
            link: {
              link_title: I18n.t('pages.about.tc_card.link_title'),
              link_url: '/curriculum',
              tracking_page: tracking_page,
              tracking_label: 'Teaching resources'
            }
          },
          {
            image_url: 'media/images/logos/isaac-logo-with-bg.svg',
            title: I18n.t('pages.about.isaac_card.title'),
            text: I18n.t('pages.about.isaac_card.text'),
            link: {
              link_title: I18n.t('pages.about.isaac_card.link_title'),
              link_url: '/a-level-computer-science',
              tracking_page: tracking_page,
              tracking_label: 'A level resources'
            }
          },
          {
            image_url: 'media/images/logos/gender-balance-logo-with-bg.svg',
            title: I18n.t('pages.about.gender_balance_card.title'),
            text: I18n.t('pages.about.gender_balance_card.text'),
            link: {
              link_title: I18n.t('pages.about.gender_balance_card.link_title'),
              link_url: '/gender-balance',
              tracking_page: tracking_page,
              tracking_label: 'Gender balance'
            }
          }
        ]
      }
    end

    def report_card
      {
        class_name: 'impact-and-evaluation-report-card',
        title: I18n.t('pages.about.report_card.title'),
        text: I18n.t('pages.about.report_card.text'),
        bullets: [
          I18n.t('pages.about.report_card.engagements.html'),
          I18n.t('pages.about.report_card.enrolments.html'),
          I18n.t('pages.about.report_card.downloads.html')
        ],
        stats_date: I18n.t('pages.about.report_card.stats_date'),
        button: {
          button_title: I18n.t('pages.about.report_card.button_title'),
          button_url: '/impact-and-evaluation',
          tracking_page: tracking_page,
          tracking_label: 'Impact and evaluation'
        }
      }
    end

    def programme_cards
      {
        class_name: 'programme-cards',
        cards: [
          {
            class_name: 'bordered-card--primary-cert',
            title: I18n.t('pages.about.primary_card.title'),
            text: I18n.t('pages.about.primary_card.text'),
            link: {
              link_title: I18n.t('pages.about.primary_card.link_title'),
              link_url: '/primary-teachers',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.primary_card.title')
            }
          },
          {
            class_name: 'bordered-card--secondary-cert',
            title: I18n.t('pages.about.secondary_card.title'),
            text: I18n.t('pages.about.secondary_card.text'),
            link: {
              link_title: I18n.t('pages.about.secondary_card.link_title'),
              link_url: '/secondary-teachers',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.secondary_card.title')
            }
          }
        ]
      }
    end

    def support_cards
      {
        class_name: 'support-cards',
        cards: [
          {
            class_name: 'supporting-partners-card',
            title: I18n.t('pages.about.supporting_partners_card.title'),
            text: I18n.t('pages.about.supporting_partners_card.text'),
            link: {
              link_title: I18n.t('pages.about.supporting_partners_card.link_title'),
              link_url: '/supporting-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.supporting_partners_card.title')
            }
          },
          {
            class_name: 'involvement-card',
            title: I18n.t('pages.about.involvement_card.title'),
            text: I18n.t('pages.about.involvement_card.text'),
            link: {
              link_title: I18n.t('pages.about.involvement_card.link_title'),
              link_url: '/get-involved',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.involvement_card.title')
            }
          },
          {
            class_name: 'contributing-partners-card',
            title: I18n.t('pages.about.contributing_partners_card.title'),
            text: I18n.t('pages.about.contributing_partners_card.text'),
            link: {
              link_title: I18n.t('pages.about.contributing_partners_card.link_title'),
              link_url: '/contributing-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.contributing_partners_card.title')
            }
          },
          {
            class_name: 'governors-card',
            title: I18n.t('pages.about.governors_card.title'),
            text: I18n.t('pages.about.governors_card.text'),
            link: {
              link_title: I18n.t('pages.about.governors_card.link_title'),
              link_url: '/governors-and-trustees/',
              tracking_page: tracking_page,
              tracking_label: 'Governors'
            }
          }
        ]
      }
    end
  end
end
