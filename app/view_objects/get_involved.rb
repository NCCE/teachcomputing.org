class GetInvolved
  class << self
    def tracking_page
      'Get involved'
    end
    def partnership_cards
      {
        class_name: 'support-cards',
        cards: [
          {
            class_name: 'supporting-partners-card',
            title: I18n.t('pages.partnerships.supporting_partner_card.title'),
            text: I18n.t('pages.partnerships.supporting_partner_card.text'),
            link: {
              link_title: I18n.t('pages.partnerships.supporting_partner_card.link_title'),
              link_url: '/supporting-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.supporting_partners_card.title')
            }
          },
          {
            class_name: 'contributing-partners-card',
            title: I18n.t('pages.partnerships.contributing_partner_card.title'),
            text: I18n.t('pages.partnerships.contributing_partner_card.text'),
            link: {
              link_title: I18n.t('pages.partnerships.contributing_partner_card.link_title'),
              link_url: '/contributing-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.partnerships.contributing_partner_card.title'),
              class_name: "button"
            }
          }
        ]
      }
    end

    def other_ways_to_get_involved_cards
      {
        class_name: 'support-cards',
        cards: [
          {
            class_name: 'supporting-partners-card',
            title: I18n.t('pages.partnerships.supporting_partner_card.title'),
            text: I18n.t('pages.partnerships.supporting_partner_card.text'),
            list_items:[],
            link: {
              link_title: I18n.t('pages.partnerships.supporting_partner_card.link_title'),
              link_url: '/supporting-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.about.supporting_partners_card.title')
            }
          },
          {
            class_name: 'contributing-partners-card',
            title: I18n.t('pages.partnerships.contributing_partner_card.title'),
            text: I18n.t('pages.partnerships.contributing_partner_card.text'),
            list_items:[],
            link: {
              link_title: I18n.t('pages.partnerships.contributing_partner_card.link_title'),
              link_url: '/contributing-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.partnerships.contributing_partner_card.title'),
              class_name: "button"
            }
          },
          {
            class_name: 'contributing-partners-card',
            title: I18n.t('pages.partnerships.contributing_partner_card.title'),
            text: I18n.t('pages.partnerships.contributing_partner_card.text'),
            list_items:["jkajssjjdfsj",'sdhhffhdkdfhjk','skjhffhjjhfksd'],
            link: {
              link_title: I18n.t('pages.partnerships.contributing_partner_card.link_title'),
              link_url: '/contributing-partners',
              tracking_page: tracking_page,
              tracking_label: I18n.t('pages.partnerships.contributing_partner_card.title'),
              class_name: "button"
            }
          }
        ]
      }
    end
  end
end
