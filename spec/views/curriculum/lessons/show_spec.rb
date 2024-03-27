require "rails_helper"

RSpec.describe("curriculum/lessons/show", type: :view) do
  let(:lesson_json) { File.new("spec/support/curriculum/views/lesson.json").read }
  let(:lesson_json_alt) { File.new("spec/support/curriculum/views/lesson_alt.json").read }
  let(:unit_json) { File.new("spec/support/curriculum/views/unit.json").read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
    json = JSON.parse(lesson_json, object_class: OpenStruct).data
    assign(:lesson, json.lesson)
  end

  let(:setup_view_with_range) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
    json = JSON.parse(lesson_json_alt, object_class: OpenStruct).data
    assign(:lesson, json.lesson)
  end

  let(:setup_view_with_range_alt) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
    json = JSON.parse(lesson_json_alt, object_class: OpenStruct).data
    json.lesson.range = "5"
    assign(:lesson, json.lesson)
  end

  let(:setup_view_without_isaac_url) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
    json = JSON.parse(lesson_json, object_class: OpenStruct).data
    json.lesson.isaac_url = ""
    assign(:lesson, json.lesson)
  end

  let(:setup_view_without_file) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
    json = JSON.parse(lesson_json, object_class: OpenStruct).data
    json.lesson.zipped_contents = nil
    assign(:lesson, json.lesson)
  end

  context "when a user is not signed in" do
    before do
      setup_view
      render
    end

    it "shows the breadcrumb partial" do
      expect(rendered).to have_link("Curriculum", href: "/curriculum")
      expect(rendered).to have_link("KS1", href: "/curriculum/key-stage-1")
      expect(rendered).to have_link("Unit", href: "/curriculum/key-stage-1/unit-1")
      expect(rendered).to have_css(".curriculum__breadcrumb", text: "Lesson")
    end

    it "has a title in the correct formart" do
      expect(rendered).to have_css(".hero__heading", text: "Lesson 2 Kicking rocks")
    end

    it "does not have a download button" do
      expect(rendered).not_to have_link("Download all lesson files", href: "https://teachcomputing.org")
    end

    it "should have a login button" do
      expect(rendered).to have_css(".govuk-button", text: "Log in to download")
    end

    it "does not show the rating partial" do
      expect(rendered).not_to have_css(".curriculum__rating")
    end
  end

  context "when there is no file" do
    before do
      setup_view_without_file
      render
    end

    it "does not show login button" do
      expect(rendered).not_to have_css(".govuk-button", text: "Log in to download")
    end
  end

  context "when a lesson has no range " do
    before do
      setup_view
      render
    end

    it "returns correct title" do
      expect(rendered).to have_css(".hero__heading", text: "Lesson 2")
    end
  end

  context "when a lesson has a range of one" do
    before do
      setup_view_with_range
      render
    end

    it "returns correct title" do
      expect(rendered).to have_css(".hero__heading", text: "Lesson 2 and 3 Kicking rocks")
    end
  end

  context "when a lesson has a range greater than one" do
    before do
      setup_view_with_range_alt
      render
    end

    it "returns correct title" do
      expect(rendered).to have_css(".hero__heading", text: "Lesson 2 to 5 Kicking rocks")
    end
  end

  context "when a lesson has a isaac url present" do
    before do
      setup_view
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "shows the gcse revision partial" do
      expect(rendered).to have_css(".gcse-revision__link")
      expect(rendered).to have_link("View on Isaac Computer Science", href: "https://www.raspberrypi.com/")
    end
  end

  context "when a lesson has NO isaac url present" do
    before do
      setup_view_without_isaac_url
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "does not show the gcse revision partial" do
      expect(rendered).not_to have_css(".gcse-revision__link")
      expect(rendered).not_to have_link("Log in to download", href: "https://teachcomputing.org")
    end
  end

  context "when a user is signed in" do
    context "lesson has file" do
      before do
        setup_view
        allow(view).to receive(:current_user).and_return(user)
        render
      end

      it "has a download button" do
        expect(rendered).to have_link(
          "Download all lesson files",
          href: "https://teachcomputing.org?user_stem_achiever_contact_no=#{user.stem_achiever_contact_no}"
        )
      end

      it "shows the rating partial" do
        expect(rendered).to have_css(".curriculum__rating")
      end
    end

    context "lesson has no file" do
      before do
        setup_view_without_file
        allow(view).to receive(:current_user).and_return(user)
        render
      end

      it "does not have a download button" do
        expect(rendered).not_to have_link(
          "Download all lesson files",
          href: "https://teachcomputing.org?user_stem_achiever_contact_no=#{user.stem_achiever_contact_no}"
        )
      end

      it "does not show the rating partial" do
        expect(rendered).not_to have_css(".curriculum__rating")
      end
    end
  end

  context "when there are no objectives present" do
    before do
      setup_view_with_range
      render
    end

    it "does not render the learning objectives partial" do
      expect(rendered).not_to have_text("Learning objectives")
    end
  end
end
