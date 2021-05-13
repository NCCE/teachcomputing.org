class AboutPage
  class << self
    def hero
      {
        class_name: 'dixie-bg',
        title: I18n.t('pages.about.hero.title'),
        text: I18n.t('pages.about.hero.text.html'),
        image_url: 'media/images/pages/about/ncce_staff.png',
        image_title: I18n.t('pages.about.hero.image_title')
      }
    end

    def resource_cards
      {
        class_name: 'resource-cards',
        cards: [
          {
            image_url: 'media/images/logos/tc-logo-with-bg.svg',
            title: I18n.t('pages.about.tc_card.title'),
            text: I18n.t('pages.about.tc_card.text'),
            link_title: I18n.t('pages.about.tc_card.link_title'),
            link_url: '/curriculum'
          },
          {
            image_url: 'media/images/logos/isaac-logo-with-bg.svg',
            title: I18n.t('pages.about.isaac_card.title'),
            text: I18n.t('pages.about.isaac_card.text'),
            link_title: I18n.t('pages.about.isaac_card.link_title'),
            link_url: '/a-level-computer-science'
          },
          {
            image_url: 'media/images/logos/gender-balance-logo-with-bg.svg',
            title: I18n.t('pages.about.gender_balance_card.title'),
            text: I18n.t('pages.about.gender_balance_card.text'),
            link_title: I18n.t('pages.about.gender_balance_card.link_title'),
            link_url: '/gender-balance'
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
          I18n.t('pages.about.report_card.engagements'),
          I18n.t('pages.about.report_card.enrolments'),
          I18n.t('pages.about.report_card.downloads')
        ],
        stats_date: I18n.t('pages.about.report_card.stats_date'),
        button_title: I18n.t('pages.about.report_card.button_title'),
        button_url: 'https://static.teachcomputing.org/NCCE_Impact_Report_Final.pdf'
      }
    end

    def programme_cards
      {
        class_name: 'programme-cards',
        cards: [
          {
            class_name: 'primary-certificate',
            title: I18n.t('pages.about.primary_card.title'),
            text: I18n.t('pages.about.primary_card.text'),
            link_title: I18n.t('pages.about.primary_card.link_title'),
            link_url: '/primary-teachers'
          },
          {
            class_name: 'secondary-certificate',
            title: I18n.t('pages.about.secondary_card.title'),
            text: I18n.t('pages.about.secondary_card.text'),
            link_title: I18n.t('pages.about.secondary_card.link_title'),
            link_url: '/secondary-teachers'
          }
        ]
      }
    end

    def support_cards
      {
        class_name: 'support-cards',
        cards: [
          {
            title: I18n.t('pages.about.supporting_partners_card.title'),
            text: I18n.t('pages.about.supporting_partners_card.text'),
            link_title: I18n.t('pages.about.supporting_partners_card.link_title'),
            link_url: '/supporting-partners'
          },
          {
            title: I18n.t('pages.about.involvement_card.title'),
            text: I18n.t('pages.about.involvement_card.text'),
            link_title: I18n.t('pages.about.involvement_card.link_title'),
            link_url: '/get-involved'
          },
          {
            title: I18n.t('pages.about.contributing_partners_card.title'),
            text: I18n.t('pages.about.contributing_partners_card.text'),
            link_title: I18n.t('pages.about.contributing_partners_card.link_title'),
            link_url: '/contributing-partners'
          },
          {
            title: I18n.t('pages.about.governors_card.title'),
            text: I18n.t('pages.about.governors_card.text'),
            link_title: I18n.t('pages.about.governors_card.link_title'),
            link_url: '/governors-and-trustees/'
          }
        ]
      }
    end
  end
end
