require "rails_helper"

RSpec.describe("pages/impact-and-evaluation", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".hero__heading", text: "Impact, evaluation and research")
  end

  it "has an introduction" do
    expect(rendered).to have_css(".govuk-body-l",
      text: "Our vision is for every child in every school in England to have a world-leading computing education.")
  end

  context "with the related links section" do
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-s", text: "Related links")
    end

    it "has the expected links" do
      expect(rendered).to have_link("About us", href: "/about")
    end
  end

  context "with the evaluation reports section" do
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-l", text: "Impact and evaluation reports")
    end

    it "has the expected links" do
      expect(rendered).to have_link("View NCCE Impact Report", href: "https://static.teachcomputing.org/NCCE-Impact-report-2022.pdf")
      expect(rendered).to have_link("Computer Science Accelerator Graduates Evaluation (cohort 2)", href: "https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort_2_Evaluation.pdf")
      expect(rendered).to have_link("NCCE Impact Report 2020", href: "https://static.teachcomputing.org/NCCE_Impact_Report_Final.pdf")
      expect(rendered).to have_link("Computer Science Accelerator Graduates Evaluation (cohort 1)", href: "https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf")
    end
  end

  context "with the curriculum reports section" do
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-l", text: "Research and curriculum reports")
    end

    it "has the expected links" do
      expect(rendered).to have_link("View Programming and Algorithms Report", href: "https://static.teachcomputing.org/Programming+and+Algorithms+Report.pdf")
      expect(rendered).to have_link("Computer Systems and Networks Report", href: "https://static.teachcomputing.org/Computer_Systems_%26_Networking_Report_-_Final.pdf")
      expect(rendered).to have_link("Digital Literacy Report", href: "https://static.teachcomputing.org/Digital-Literacy-Within-the-Computing-Curriculum.pdf")
      expect(rendered).to have_link("International Computing Textbook Review", href: "https://static.teachcomputing.org/International_Textbook_Review.pdf")
      expect(rendered).to have_link("Practical Programming White Paper", href: "https://static.teachcomputing.org/Practical+Work+in+Computing+Apr+22.pdf")
      expect(rendered).to have_link("Gender Insights in Computing Education", href: "https://static.teachcomputing.org/Gender_Insights_in_Computing_Education_Foundational_Evidence_Review.pdf")
    end
  end

  context "with the research resources section" do
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-l", text: "Our research resources")
    end

    it "has the expected links" do
      expect(rendered).to have_link("Take part in our research", href: "/gender-balance")
      expect(rendered).to have_link("Pedagogy resources", href: "/pedagogy")
    end
  end

  context "with the other resources section" do
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-l", text: "You might also be interested in")
    end

    it "has an introduction" do
      expect(rendered).to have_css(".govuk-body-m",
        text: "STEM Learning has additional content around impact, evaluation and research you may find valuable.")
    end

    it "has the expected links" do
      expect(rendered).to have_link("Impact and evaluation", href: "https://www.stem.org.uk/impact-and-evaluation")
    end
  end
end
