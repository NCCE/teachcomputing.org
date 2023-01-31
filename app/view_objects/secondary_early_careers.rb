class SecondaryEarlyCareers
  class << self
    def communities
      {
        class_name: 'support-cards',
        cards: [
          {
            class_name: 'computing_hubs',
            title: I18n.t('pages.secondary_early_careers.computing_hubs.title'),
            text: I18n.t('pages.secondary_early_careers.computing_hubs.text'),
            image_url: 'get-involved/stem.svg',
            link: {
              link_title: I18n.t('pages.secondary_early_careers.computing_hubs.link_title'),
              link_url: 'https://codeclub.org/en/volunteer',
              tracking_page: '',
              tracking_label: I18n.t('pages.about.supporting_partners_card.title'),
            }
          },
          {
            class_name: 'stem-card',
            title: I18n.t('pages.secondary_early_careers.stem_community.title'),
            text: I18n.t('pages.secondary_early_careers.stem_community.text'),
            image_url: 'get-involved/stem.svg',
            link: {
              link_title: I18n.t('pages.secondary_early_careers.stem_community.link_title'),
              link_url: 'https://www.stem.org.uk/stem-ambassadors/join-stem-ambassador-programme',
              tracking_page: '',
              tracking_label: I18n.t('pages.secondary_early_careers.stem_community.title'),
            }
          },
          {
            class_name: 'isac-computer-card',
            title: I18n.t('pages.secondary_early_careers.csa_communities.title'),
            text: I18n.t('pages.secondary_early_careers.csa_communities.text'),
            image_url: 'get-involved/stem.svg',
            link: {
              link_title: I18n.t('pages.secondary_early_careers.csa_communities.link_title'),
              link_url: 'https://isaaccomputerscience.org/pages/getintouch_events',
              tracking_page: '',
              tracking_label: I18n.t('pages.secondary_early_careers.csa_communities.title'),
            }
          }
        ]
      }
    end
  end
end
