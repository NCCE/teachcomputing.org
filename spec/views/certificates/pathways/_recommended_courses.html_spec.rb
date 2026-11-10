require "rails_helper"

RSpec.describe("certificates/pathways/_recommended_courses", type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:pathway) { create(:pathway, programme:) }
  let(:pathway_activities) { create_list(:pathway_activity, 5, pathway:) }
  let(:visible_titles) { pathway_activities.first(2).map { _1.activity.title } }
  let(:extra_titles) { pathway_activities.drop(2).map { _1.activity.title } }
  let(:extra_courses) { "##{courses_id}" }
  let(:courses_id) { "recommended-courses-#{pathway.id}" }

  before do
    stub_course_templates
    stub_duration_units
    @current_user = user
    @programme = programme
  end

  def render_partial(**locals)
    render partial: "certificates/pathways/recommended_courses", locals: {
      event_category: "CSA enrolled",
      pathway:,
      recommended_activities: pathway_activities
    }.merge(locals)
  end

  context "when starting expanded" do
    before { render_partial }

    it "shows the title" do
      expect(rendered).to have_css("p strong", text: "Courses based on your pathway")
    end

    it "shows the first two courses outside the expander" do
      visible_titles.each do |title|
        expect(rendered).to have_link(title)
        expect(rendered).not_to have_css(extra_courses, text: title)
      end
    end

    it "puts the rest of the courses in the expander" do
      extra_titles.each do |title|
        expect(rendered).to have_css(extra_courses, text: title)
      end
    end

    it "has a green toggle button to show fewer courses" do
      expect(rendered).to have_css("button.govuk-button.button:not(.button--inverted)[aria-expanded='true'][start-expanded='true'][aria-controls='#{courses_id}']", text: "Show fewer courses")
    end

    it "puts the toggle button next to the title" do
      expect(rendered).to have_css(".ncce-pathway-courses__header strong", text: "Courses based on your pathway")
      expect(rendered).to have_css(".ncce-pathway-courses__header button[data-action='expander#toggleAll']")
    end

    it "has the button text for both states" do
      expect(rendered).to have_css("[data-controller='expander'][data-expander-expand-value='Show all 5 courses'][data-expander-collapse-value='Show fewer courses']")
    end

    it "puts the browse all courses link at the bottom of the expander" do
      expect(rendered).to have_css("#{extra_courses} .ncce-pathway-courses__buttons:last-child a", text: "Browse all certificate courses")
      expect(rendered).to have_link("Browse all certificate courses", count: 1)
    end
  end

  context "when starting collapsed" do
    before { render_partial(start_expanded: false) }

    it "has a toggle button to show all the courses" do
      expect(rendered).to have_css("button[aria-expanded='false'][start-expanded='false']", text: "Show all 5 courses")
    end
  end

  context "with a custom title" do
    before { render_partial(title: "Your pathway courses") }

    it "shows the custom title" do
      expect(rendered).to have_css("p strong", text: "Your pathway courses")
    end
  end

  context "when there are no more than two courses" do
    let(:pathway_activities) { create_list(:pathway_activity, 2, pathway:) }

    before { render_partial(start_expanded: false) }

    it "shows all the courses" do
      visible_titles.each { expect(rendered).to have_link(_1) }
    end

    it "does not have a toggle button" do
      expect(rendered).not_to have_css("[data-controller='expander']")
      expect(rendered).not_to have_button
    end

    it "always shows the browse all courses link" do
      expect(rendered).to have_link("Browse all certificate courses", count: 1)
      expect(rendered).not_to have_css("[data-expander-target]")
    end
  end

  context "when there is no pathway" do
    let(:pathway) { nil }
    let(:pathway_activities) { nil }

    before { render_partial }

    it "does not show the title or a toggle button" do
      expect(rendered).not_to have_css("p strong")
      expect(rendered).not_to have_button
    end

    it "shows the browse all courses link" do
      expect(rendered).to have_link("Browse all certificate courses", href: courses_path(certificate: programme.slug))
    end
  end
end
