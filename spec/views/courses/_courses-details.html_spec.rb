require "rails_helper"

RSpec.describe("courses/_courses-details", type: :view) do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:age_groups) { Achiever::Course::AgeGroup.all }
  let(:subjects) { Achiever::Course::Subject.all }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    stub_duration_units
    stub_age_groups
    stub_subjects
    stub_face_to_face_occurrences
    stub_course_templates

    assign(:course, course)
  end

  describe "a remote course" do
    let(:course) { Achiever::Course::Template.find_by_activity_code("CP428") }
    let(:occurrences) { build_list(:achiever_course_occurrence, 3, remote_delivered_cpd: true) }

    before do
      assign(:age_groups, age_groups)
      assign(:occurrences, occurrences)
      assign(:subjects, subjects)

      render
    end

    it "has an age tag" do
      expect(rendered).to have_css(".ncce-courses__tag", text: "Key stage 4")
    end

    it "has a subject tag" do
      expect(rendered).to have_css(".ncce-courses__tag", text: "Programming")
      expect(rendered).to have_css(".ncce-courses__tag", text: "Data & information")
    end

    it "has a programme tag" do
      expect(rendered).to have_css(".ncce-courses__tag", text: "Subject Knowledge")
    end

    it "displays the course type" do
      expect(rendered).to have_css(".icon-remote", text: "Live remote training course")
    end

    it "displays the time" do
      expect(rendered).to have_css(".icon-clock", text: "5 hours")
    end

    it "displays the correct title for the occurrences" do
      expect(rendered).to have_css(".ncce-courses__locations", text: "View dates")
    end

    it "displays the correct number of occurrences" do
      expect(rendered).to have_css(".ncce-courses__meta-item", count: 3)
    end

    it "displays the expected content for an occurrence" do
      expect(rendered).to have_css(".ncce-courses__meta-location", text: "Live remote training", count: 3)
      expect(rendered).to have_css(".ncce-courses__meta-date", text: "15 January 00:00—15 February 2099")
    end
  end

  describe "a face to face course" do
    let(:course) { Achiever::Course::Template.find_by_activity_code("CP238") }
    let(:occurrences) { build_list(:achiever_course_occurrence, 3) }

    before do
      assign(:age_groups, age_groups)
      assign(:occurrences, occurrences)

      render
    end

    it "has an age tag" do
      expect(rendered).to have_css(".ncce-courses__tag", text: "Key stage 3")
      expect(rendered).to have_css(".ncce-courses__tag", text: "Key stage 4")
    end

    it "displays the course type" do
      expect(rendered).to have_css(".icon-map-pin", text: "Face to face course")
    end

    it "displays the time" do
      expect(rendered).to have_css(".icon-clock", text: "1 day")
    end

    it "displays the correct title for the occurrences" do
      expect(rendered).to have_css(".ncce-courses__locations", text: "View locations and dates")
    end

    it "displays the expected content for an occurrence" do
      expect(rendered).to have_css(".ncce-courses__meta-location", text: occurrences.first.address_town)
      expect(rendered).to have_css(".ncce-courses__meta-date", text: "15 January 00:00—15 February 2099")
    end
  end

  describe "an online course" do
    let(:course) { Achiever::Course::Template.find_by_activity_code("CO214") }
    let(:occurrences) { build_list(:achiever_course_occurrence, 3, online_cpd: true) }

    before do
      assign(:age_groups, age_groups)
      assign(:occurrences, occurrences)

      render
    end

    it "displays the course type" do
      expect(rendered).to have_css(".icon-online", text: "Free online course")
    end

    it "displays the time" do
      expect(rendered).to have_css(".icon-clock", text: "4 weeks")
    end

    it "does not display occurrences" do
      expect(rendered).not_to have_css(".ncce-courses__locations")
    end
  end
end
