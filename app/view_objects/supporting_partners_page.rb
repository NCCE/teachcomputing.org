class SupportingPartnersPage
  class << self
    def hero
      {
        class_name: "lime-green-bg",
        title: I18n.t("pages.partnerships.hero.title"),
        text: I18n.t("pages.partnerships.hero.text.html"),
        image: {
          url: "media/images/pages/supporting_partners/supporting_partners.png",
          title: I18n.t("pages.about.hero.image_title")
        }
      }
    end

    def cards
      [
        {
          title_locale: "pages.supporting_partners.arm.title",
          link_url: "https://www.arm.com/",
          image_path: "media/images/partners/arm.svg",
          img_alt_locale: "pages.supporting_partners.arm.img_alt",
          text_locale: "pages.supporting_partners.arm.text_html"
        },
        {
          title_locale: "pages.supporting_partners.bt.title",
          link_url: "https://www.bt.com/skillsfortomorrow",
          image_path: "media/images/partners/bt.svg",
          img_alt_locale: "pages.supporting_partners.bt.img_alt",
          text_locale: "pages.supporting_partners.bt.text_html"
        },
        {
          title_locale: "pages.supporting_partners.google.title",
          link_url: "https://edu.google.com/teaching-resources/?modal_active=none&topic=coding-and-computer-science",
          image_path: "media/images/partners/google.svg",
          img_alt_locale: "pages.supporting_partners.google.img_alt",
          text_locale: "pages.supporting_partners.google.text_html"
        },
        {
          title_locale: "pages.supporting_partners.ibm.title",
          link_url: "https://www.ibm.org/",
          image_path: "media/images/partners/ibm.svg",
          img_alt_locale: "pages.supporting_partners.ibm.img_alt",
          text_locale: "pages.supporting_partners.ibm.text_html"
        },
        {
          title_locale: "pages.supporting_partners.nationwide.title",
          link_url: "https://www.nationwide-jobs.co.uk/",
          image_path: "media/images/partners/nationwide.svg",
          img_alt_locale: "pages.supporting_partners.nationwide.img_alt",
          text_locale: "pages.supporting_partners.nationwide.text_html"
        },
        {
          title_locale: "pages.supporting_partners.rolls_royce.title",
          link_url: "https://www.stem.org.uk/rolls-royce-schools-prize-science-technology",
          image_path: "media/images/partners/rolls-royce.svg",
          img_alt_locale: "pages.supporting_partners.rolls_royce.img_alt",
          text_locale: "pages.supporting_partners.rolls_royce.text_html"
        }
      ]
    end
  end
end
