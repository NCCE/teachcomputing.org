require "rails_helper"
require "axe/rspec"

RSpec.describe("Courses page", type: :system) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects
    stub_age_groups
    stub_course_templates
    stub_duration_units
  end

  context "when using a desktop", js: true do
    before do
      resize_window_to_desktop
      visit courses_path
    end

    describe "with no filters applied" do
      it "is the correct page" do
        expect(page).to have_content("Computing courses for teachers")
      end

      it "shows the expected number of results" do
        expect(page).to have_css(".ncce-courses__count", text: "Showing 79 results")
      end

      it "does not show the toggle menu" do
        expect(page).not_to have_css(".ncce-courses__filter-form-toggle--open")
      end
    end

    describe "with a checkbox filter" do
      before do
        check("course_length_0", visible: false)
      end

      it "shows the expected number of results" do
        expect(page).to have_css(".ncce-courses__count", text: "Showing 3 results")
      end
    end

    describe "with a select filter" do
      before do
        select("Key stage 1", from: "level")
      end

      it "shows the expected number of results" do
        expect(page).to have_css(".ncce-courses__count", text: "Showing 14 results")
      end
    end
  end

  context "when using a mobile device" do
    before do
      resize_window_to_mobile
      visit courses_path
    end

    describe "with no filters applied" do
      it "the menu is collapsed by default" do
        expect(page).not_to have_css(".ncce-courses__filter-form-toggle--open")
      end

      it "shows the menu when clicked" do
        click_button(class: "ncce-courses__filter-form-toggle")
        expect(page).to have_css(".ncce-courses__filter-form-toggle--open")
      end

      it "closes the menu when clicked twice" do
        click_button(class: "ncce-courses__filter-form-toggle")
        expect(page).to have_css(".ncce-courses__filter-form-toggle--open")
        click_button(class: "ncce-courses__filter-form-toggle--open")
        expect(page).not_to have_css(".ncce-courses__filter-form-toggle--open")
      end

      it "shows the expected number of results" do
        expect(page).to have_css(".ncce-courses__count", text: "Showing 79 results")
      end
    end

    describe "with filters applied" do
      before do
        click_button(class: "ncce-courses__filter-form-toggle")
        check("course_length_1", visible: false)
      end

      it "shows the expected number of results" do
        expect(page).to have_css(".ncce-courses__count", text: "Showing 22 results")
      end

      it "shows the expected number of filters" do
        expect(page).to have_css(".ncce-courses__filter-form-toggle-applied", text: "1 filter applied")
      end

      it "increases the filter count when another filter is clicked" do
        check("course_length_2", visible: false)
        expect(page).to have_css(".ncce-courses__filter-form-toggle-applied", text: "2 filters applied")
      end

      it "shows the expected number of filters when the menu is closed" do
        click_button(class: "ncce-courses__filter-form-toggle--open")
        expect(page).to have_css(".ncce-courses__filter-form-toggle-applied", text: "1 filter applied")
      end
    end
  end
end
