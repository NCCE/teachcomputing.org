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
    it "is the number of courses based on the pathway" do
      expect(component.title).to eq("5 courses based on your pathway")
    end

    context "with one course" do
      let(:recommended_activities) { create_list(:pathway_activity, 1, pathway:) }

      it { expect(component.title).to eq("1 course based on your pathway") }
    end
  end

  context "when rendered starting expanded" do
    before { render_inline(component) }

    it "makes the title the toggle button" do
      expect(page).to have_css("button.expander__button[aria-expanded='true'][start-expanded='true'][aria-controls='#{courses_id}'] strong", text: "5 courses based on your pathway")
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

    it "wires the toggle button to the expander" do
      expect(page).to have_css("[data-controller='expander'] .ncce-pathway-courses__header button[data-action='expander#toggleAll'][data-expander-target='expanderButton'][data-event-category='CSA enrolled']")
    end

    it "has only the title in the toggle button" do
      expect(page).to have_button(exact_text: "5 courses based on your pathway", normalize_ws: true, count: 1)
    end

    it "puts the browse all courses link at the bottom of the expander" do
      expect(page).to have_css("#{extra_courses} .ncce-pathway-courses__buttons:last-child a", text: "Browse all certificate courses")
      expect(page).to have_link("Browse all certificate courses", count: 1)
    end
  end

  context "when rendered starting collapsed" do
    before { render_inline(component(start_expanded: false)) }

    it "has the title as a collapsed toggle button" do
      expect(page).to have_css("button[aria-expanded='false'][start-expanded='false']", text: "5 courses based on your pathway")
    end

    it "hides the expander before the JavaScript runs" do
      expect(page).to have_css("#{extra_courses}.expander.hidden", visible: :all)
    end
  end

  context "when rendered with a description" do
    before do
      render_inline(component) do |c|
        c.with_description { "Your pathway (PDF)" }
      end
    end

    it "shows the description after the title, outside the toggle button" do
      expect(page).to have_css(".ncce-pathway-courses__header button + p", text: "Your pathway (PDF)")
      expect(page).not_to have_css("button", text: "Your pathway (PDF)")
    end
  end

  context "when rendered without a description" do
    before { render_inline(component) }

    it "does not leave an empty paragraph in the header" do
      expect(page).not_to have_css(".ncce-pathway-courses__header p")
    end
  end

  context "when rendered with no more than two courses" do
    let(:recommended_activities) { create_list(:pathway_activity, 2, pathway:) }

    before { render_inline(component(start_expanded: false)) }

    it "shows all the courses" do
      visible_titles.each { expect(page).to have_link(_1) }
    end

    it "shows the title as text" do
      expect(page).to have_css(".ncce-pathway-courses__header p strong", text: "2 courses based on your pathway")
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
