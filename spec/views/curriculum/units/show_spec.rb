require "rails_helper"

RSpec.describe("curriculum/units/show", type: :view) do
  let(:unit_json) { File.new("spec/support/curriculum/views/unit.json").read }
  let(:unit_json_with_video) { File.new("spec/support/curriculum/views/unit_with_video.json").read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
  end
  let(:setup_view_without_isaac_url) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    json.unit.isaac_url = ""
    assign(:unit, json.unit)
  end
  let(:setup_view_with_video) do
    json = JSON.parse(unit_json_with_video, object_class: OpenStruct).data
    json.unit.isaac_url = ""
    assign(:unit, json.unit)
  end

  context "when a video is not present" do
    before do
      setup_view
      render
    end

    it "does not render a video component" do
      expect(rendered).to_not have_css(".video-component-row")
    end
  end

  context "when a video is present" do
    before do
      setup_view_with_video
      render
    end

    it "renders the video component" do
      expect(rendered).to have_css(".video-component-row")
    end
    it "renders the video embed" do
      expect(rendered).to have_css("iframe")
    end
  end

  context "when a user is not signed in" do
    before do
      setup_view
      render
    end

    it "shows the breadcrumb partial" do
      expect(rendered).to have_link("Curriculum", href: "/curriculum")
      expect(rendered).to have_link("KS1", href: "/curriculum/key-stage-1")
      expect(rendered).to have_css(".curriculum__breadcrumb", text: "Unit")
    end

    it "has a title" do
      expect(rendered).to have_css(".hero__heading", text: "Unit 1")
    end

    it "links to feedback form" do
      expect(rendered).to have_link("Provide your feedback", href: "https://survey.alchemer.eu/s3/90535031/National-Centre-for-Computing-Education-Teach-Computing-Curriculum-Feedback")
    end

    it "does not show the rating partial" do
      expect(rendered).not_to have_css(".curriculum__rating")
    end
  end

  context "when a user is signed in" do
    before do
      setup_view
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "shows the rating partial" do
      expect(rendered).to have_css(".curriculum__rating")
    end
  end

  context "when a unit has a isaac url present" do
    before do
      setup_view
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "shows the gcse revision partial" do
      expect(rendered).to have_css(".gcse-revision__link")
    end
  end

  context "when a unit has NO isaac url present" do
    before do
      setup_view_without_isaac_url
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "does not show the gcse revision partial" do
      expect(rendered).not_to have_css(".gcse-revision__link")
    end
  end

  context "when a url link is present" do
    before do
      setup_view
      render
    end

    it "renders the external link component" do
      expect(rendered).to have_css(".external-link-card-component")
    end
  end

  context "when a url link is not present" do
    before do
      setup_view_with_video
      render
    end

    it "renders the external link component" do
      expect(rendered).to_not have_css(".external-link-card-component")
    end
  end
end
