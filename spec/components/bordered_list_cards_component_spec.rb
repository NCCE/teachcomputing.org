require "rails_helper"

RSpec.describe BorderedListCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: "support-cards",
      cards: [
        {
          class_name: "code-club-card",
          title: "Volunteer at a Code Club",
          text: "",
          image_url: "get-involved/codeclub.svg",
          link: {
            link_title: "Volunteer at a Code Club",
            link_url: "https://codeclub.org/en/volunteer",
            tracking_page: "test_page",
            tracking_label: "Code Club"
          }
        },
        {
          class_name: "stem-card",
          title: "Become an Ambassador",
          text: "",
          image_url: "get-involved/stem.svg",
          link: {
            link_title: "Become an Ambassador",
            link_url: "https://www.stem.org.uk/stem-ambassadors/join-stem-ambassador-programme",
            tracking_page: "test_page",
            tracking_label: "STEM Ambassador"
          }
        },
        {
          class_name: "isac-computer-card",
          title: "Help at a Discovery event",
          text: "",
          image_url: "get-involved/isac.svg",
          link: {
            link_title: "Help at a Discovery event",
            link_url: "https://isaaccomputerscience.org/pages/getintouch_events",
            tracking_page: "test_page",
            tracking_label: "Isaac Computing"
          }
        },
        {
          class_name: "cas-card",
          title: "Join Computing at School",
          text: "Join Computing at School",
          image_url: "get-involved/cas.svg",
          link: {
            link_title: "Join Computing at School",
            link_url: "https://www.computingatschool.org.uk/",
            tracking_page: "test_page",
            tracking_label: "CAS"
          }
        },
        {
          class_name: "school-governors-card",
          title: "Advocate for us",
          text: "Advocate for us",
          image_url: "get-involved/school_governors.svg",
          link: {
            link_title: "Advocate for us",
            link_url: "https://teachcomputing.org/governors-and-trustees/",
            tracking_page: "test_page",
            tracking_label: "School Governors"
          }
        }
      ]
    }
  end

  context "other ways to get involved cards" do
    before do
      test_data[:cards][0][:image_url] = "media/images/logos/isaac-logo-with-bg.svg"
      render_inline(described_class.new(**test_data))
    end

    it "has the expected links" do
      expect(page).to have_link("Volunteer at a Code Club", href: "https://codeclub.org/en/volunteer")
      expect(page).to have_link("Become an Ambassador", href: "https://www.stem.org.uk/stem-ambassadors/join-stem-ambassador-programme")
      expect(page).to have_link("Help at a Discovery event", href: "https://isaaccomputerscience.org/pages/getintouch_events")
      expect(page).to have_link("Join Computing at School", href: "https://www.computingatschool.org.uk/")
      expect(page).to have_link("Advocate for us", href: "https://teachcomputing.org/governors-and-trustees/")
    end

    it "sets the expected properties" do
      expect(page).to have_xpath('//div[contains(@class, "bordered-cards")][contains(@style, "--cards-per-row: 3;")]')
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".support-cards")
    end

    it "renders the expected number of cards" do
      expect(page).to have_css(".bordered-card", count: 5)
    end

    it "renders an image" do
      expect(page).to have_css(".bordered-card__image-wrapper")
    end
  end
end
