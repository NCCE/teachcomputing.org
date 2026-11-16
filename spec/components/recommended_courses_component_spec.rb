require "rails_helper"

RSpec.describe RecommendedCoursesComponent, type: :component do
  let(:current_user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:pathway) { create(:pathway, programme:) }
  let(:recommended_activities) { create_list(:pathway_activity, 5, pathway:) }
  let(:visible_titles) { recommended_activities.first(2).map { _1.activity.title } }
  let(:extra_titles) { recommended_activities.drop(2).map { _1.activity.title } }
  let(:courses_id) { "recommended-courses-#{pathway.id}" }
  let(:extra_courses) { "##{courses_id}" }

  before do
    stub_course_templates
    stub_duration_units
  end

  def component(**args)
    described_class.new(
      current_user:,
      programme:,
      pathway:,
      recommended_activities:,
      event_category: "CSA enrolled",
      **args
    )
  end

  describe "#visible_activities and #extra_activities" do
    it "splits the courses after the first two" do
      expect(component.visible_activities).to eq(recommended_activities.first(2))
      expect(component.extra_activities).to eq(recommended_activities.drop(2))
    end
  end

  describe "#expandable?" do
    it "is true when there are more than two courses" do
      expect(component).to be_expandable
    end

    context "with two courses" do
      let(:recommended_activities) { create_list(:pathway_activity, 2, pathway:) }

      it { expect(component).not_to be_expandable }
    end

    context "without a pathway" do
      let(:pathway) { nil }
      let(:recommended_activities) { create_list(:pathway_activity, 3) }

      it { expect(component).not_to be_expandable }
    end
  end

  describe "#title" do
    it "defaults to the pathway title" do
      expect(component.title).to eq("Courses based on your pathway")
    end

    it "uses a custom title" do
      expect(component(title: "Your pathway courses").title).to eq("Your pathway courses")
    end
  end

  describe "#toggle_label" do
    it "offers to show fewer courses when starting expanded" do
      expect(component.toggle_label).to eq("Show fewer courses")
    end

    it "offers to show all the courses when starting collapsed" do
      expect(component(start_expanded: false).toggle_label).to eq("Show all 5 courses")
    end
  end

  context "when rendered starting expanded" do
    before { render_inline(component) }

    it "shows the title" do
      expect(page).to have_css("p strong", text: "Courses based on your pathway")
    end

    it "shows the first two courses outside the expander" do
      visible_titles.each do |title|
        expect(page).to have_link(title)
        expect(page).not_to have_css(extra_courses, text: title)
      end
    end

    it "puts the rest of the courses in the expander" do
      extra_titles.each do |title|
        expect(page).to have_css(extra_courses, text: title)
      end
    end

    it "does not hide the expander" do
      expect(page).to have_css("#{extra_courses}.expander:not(.hidden)")
    end

    it "has a green toggle button to show fewer courses" do
      expect(page).to have_css("button.govuk-button.button:not(.button--inverted)[aria-expanded='true'][start-expanded='true'][aria-controls='#{courses_id}']", text: "Show fewer courses")
    end

    it "puts the toggle button next to the title" do
      expect(page).to have_css(".ncce-pathway-courses__header strong", text: "Courses based on your pathway")
      expect(page).to have_css(".ncce-pathway-courses__header button[data-action='expander#toggleAll'][data-event-category='CSA enrolled']")
    end

    it "has the button text for both states" do
      expect(page).to have_css("[data-controller='expander'][data-expander-expand-value='Show all 5 courses'][data-expander-collapse-value='Show fewer courses']")
    end

    it "puts the browse all courses link at the bottom of the expander" do
      expect(page).to have_css("#{extra_courses} .ncce-pathway-courses__buttons:last-child a", text: "Browse all certificate courses")
      expect(page).to have_link("Browse all certificate courses", count: 1)
    end
  end

  context "when rendered starting collapsed" do
    before { render_inline(component(start_expanded: false)) }

    it "has a toggle button to show all the courses" do
      expect(page).to have_css("button[aria-expanded='false'][start-expanded='false']", text: "Show all 5 courses")
    end

    it "hides the expander before the JavaScript runs" do
      expect(page).to have_css("#{extra_courses}.expander.hidden", visible: :all)
    end
  end

  context "when rendered with a custom title" do
    before { render_inline(component(title: "Your pathway courses")) }

    it "shows the custom title" do
      expect(page).to have_css("p strong", text: "Your pathway courses")
    end
  end

  context "when rendered with no more than two courses" do
    let(:recommended_activities) { create_list(:pathway_activity, 2, pathway:) }

    before { render_inline(component(start_expanded: false)) }

    it "shows all the courses" do
      visible_titles.each { expect(page).to have_link(_1) }
    end

    it "does not have a toggle button" do
      expect(page).not_to have_css("[data-controller='expander']")
      expect(page).not_to have_button
    end

    it "always shows the browse all courses link" do
      expect(page).to have_link("Browse all certificate courses", count: 1)
      expect(page).not_to have_css("[data-expander-target]")
    end
  end

  context "when rendered without a pathway" do
    let(:pathway) { nil }
    let(:recommended_activities) { create_list(:pathway_activity, 3) }

    before { render_inline(component) }

    it "does not show the title, courses or a toggle button" do
      expect(page).not_to have_css("p strong")
      expect(page).not_to have_css("[data-expander-target]")
      expect(page).not_to have_button
    end

    it "shows the browse all courses link" do
      expect(page).to have_link("Browse all certificate courses", href: "/courses?certificate=#{programme.slug}")
    end
  end
end
