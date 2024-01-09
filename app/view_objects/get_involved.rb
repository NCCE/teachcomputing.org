class GetInvolved
  class << self
    def tracking_page
      "Get involved"
    end

    def partnership_cards
      {
        class_name: "support-cards",
        cards: [
          {
            class_name: "supporting-partners-card",
            title: I18n.t("pages.partnerships.supporting_partner_card.title"),
            text: I18n.t("pages.partnerships.supporting_partner_card.text"),
            button: true,
            link: {
              link_title: I18n.t("pages.partnerships.supporting_partner_card.link_title"),
              link_url: "/supporting-partners",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.about.supporting_partners_card.title")
            }
          },
          {
            class_name: "contributing-partners-card",
            title: I18n.t("pages.partnerships.contributing_partner_card.title"),
            text: I18n.t("pages.partnerships.contributing_partner_card.text"),
            button: true,
            link: {
              link_title: I18n.t("pages.partnerships.contributing_partner_card.link_title"),
              link_url: "/contributing-partners",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.partnerships.contributing_partner_card.title")
            }
          }
        ]
      }
    end

    def other_ways_to_get_involved_cards
      {
        class_name: "support-cards",
        cards: [
          {
            class_name: "code-club-card",
            title: I18n.t("pages.other_ways_to_get_involved.code_club.title"),
            text: "",
            list_items: I18n.t("pages.other_ways_to_get_involved.code_club.list_items"),
            image_url: "get-involved/codeclub.svg",
            link: {
              link_title: I18n.t("pages.other_ways_to_get_involved.code_club.link_title"),
              link_url: "https://codeclub.org/en/volunteer",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.about.supporting_partners_card.title")
            }
          },
          {
            class_name: "stem-card",
            title: I18n.t("pages.other_ways_to_get_involved.stem_ambassador.title"),
            text: "",
            list_items: I18n.t("pages.other_ways_to_get_involved.stem_ambassador.list_items"),
            image_url: "get-involved/stem.svg",
            link: {
              link_title: I18n.t("pages.other_ways_to_get_involved.stem_ambassador.link_title"),
              link_url: "https://www.stem.org.uk/stem-ambassadors/join-stem-ambassador-programme",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.other_ways_to_get_involved.stem_ambassador.title")
            }
          },
          {
            class_name: "isac-computer-card",
            title: I18n.t("pages.other_ways_to_get_involved.isac_computing.title"),
            text: "",
            list_items: I18n.t("pages.other_ways_to_get_involved.isac_computing.list_items"),
            image_url: "get-involved/isac.svg",
            link: {
              link_title: I18n.t("pages.other_ways_to_get_involved.isac_computing.link_title"),
              link_url: "https://isaaccomputerscience.org/pages/getintouch_events",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.other_ways_to_get_involved.isac_computing.title")
            }
          },
          {
            class_name: "cas-card",
            title: I18n.t("pages.other_ways_to_get_involved.cas.title"),
            text: I18n.t("pages.other_ways_to_get_involved.cas.text"),
            list_items: I18n.t("pages.other_ways_to_get_involved.cas.list_items"),
            image_url: "get-involved/cas.svg",
            link: {
              link_title: I18n.t("pages.other_ways_to_get_involved.cas.link_title"),
              link_url: "https://www.computingatschool.org.uk/",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.other_ways_to_get_involved.cas.title")
            }
          },
          {
            class_name: "school-governors-card",
            title: I18n.t("pages.other_ways_to_get_involved.school_governors.title"),
            text: I18n.t("pages.other_ways_to_get_involved.school_governors.text"),
            list_items: I18n.t("pages.other_ways_to_get_involved.school_governors.list_items"),
            image_url: "get-involved/school_governors.svg",
            link: {
              link_title: I18n.t("pages.other_ways_to_get_involved.school_governors.link_title"),
              link_url: "https://teachcomputing.org/governors-and-trustees/",
              tracking_page: tracking_page,
              tracking_label: I18n.t("pages.other_ways_to_get_involved.school_governors.title")
            }
          }
        ]
      }
    end
  end
end
