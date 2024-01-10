require "rails_helper"

RSpec.describe DocumentCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: "evaluation-cards",
      show_border: true,
      cards_per_row: 2,
      cards: [
        {
          class_name: "impact-graduates-card",
          title_link: {
            title: "Computer Science Accelerator Graduates Evaluation (cohort 2)",
            url: "https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort_2_Evaluation.pdf"
          },
          date: "Published July 2021",
          body: {
            text: "Read the experiences of our second cohort of graduates and the impact of completing the programme (now known as KS3 and GCSE Computer Science subject knowledge certificate) on themselves, their students and colleagues. "
          }
        },
        {
          class_name: "impact-graduates-card",
          title_link: {
            title: "Computer Science Accelerator Graduates Evaluation (cohort 1)",
            url: "https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf"
          },
          date: "Published October 2020",
          body: {
            text: "Reviews feedback from the first graduates of the programme (now known as KS3 and GCSE Computer Science subject knowledge certificate), covering programme quality, value, impact, and overall experience."
          }
        }
      ]
    }
  end

  context "with no date" do
    before do
      test_data[:cards][0][:date] = nil
      render_inline(described_class.new(**test_data))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".evaluation-cards")
    end

    it "renders the expected number of cards" do
      expect(page).to have_css(".document-card", count: 2)
    end

    it "sets show-border data attribute" do
      expect(page).to have_css(".evaluation-cards[data-show-border='true']")
    end

    it "sets the expected properties" do
      expect(page).to have_xpath('//div[contains(@class, "document-cards-component")][contains(@style, "--cards-per-row: 2;")]')
    end

    it "adds the card wrapper class" do
      expect(page).to have_css(".impact-graduates-card")
    end

    it "renders a title" do
      expect(page).to have_link(
        "Computer Science Accelerator Graduates Evaluation (cohort 1)",
        href: "https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf"
      )
    end

    it "does not render any dates" do
      expect(page).to have_css(".document-card__date")
    end

    it "renders the body text" do
      expect(page).to have_css(
        ".document-card__text",
        text: "Reviews feedback from the first graduates of the programme (now known as KS3 and GCSE Computer Science subject knowledge certificate), covering programme quality, value, impact, and overall experience."
      )
    end
  end

  context "with a date" do
    before do
      render_inline(described_class.new(**test_data))
    end

    it "renders a date" do
      expect(page).to have_css(".document-card__date", text: "Published October 2020")
    end
  end
end
