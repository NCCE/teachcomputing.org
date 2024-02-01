require "rails_helper"

RSpec.describe("components/_hero", type: :view) do
  let(:hero_title) { "Page title" }
  let(:colour) { "lime-green" }
  let(:status) { "You are amazing" }
  let(:subtitle) { "Some text here everybody" }

  context "when no title is passed in" do
    it "raises error if title is nil" do
      expect {
        render
      }.to raise_error(ActionView::Template::Error)
    end
  end

  context "when only the title is passed in" do
    before do
      render template: "components/_hero", locals: {hero_title: hero_title}
    end

    it "shows the title" do
      expect(rendered).to have_css(".hero__heading", text: hero_title)
    end

    it "is the lime green hero" do
      expect(rendered).to have_css(".hero--lime-green", count: 1)
    end

    it "doesn't show the status message" do
      expect(rendered).not_to have_css(".hero__status", count: 1)
    end

    it "doesn't show the subtitle" do
      expect(rendered).not_to have_css(".hero__text", count: 1)
    end

    it "header width is normal" do
      expect(rendered).not_to have_css(".hero__heading-wrapper--full-width", count: 1)
    end
  end

  context "when colour is passed in" do
    before do
      render template: "components/_hero", locals: {hero_title: hero_title, colour: colour}
    end

    it "is not the plain hero" do
      expect(rendered).not_to have_css(".hero--plain", count: 1)
    end

    it "is has the colour set" do
      expect(rendered).to have_css(".hero--#{colour}", count: 1)
    end
  end

  context "when status_message is passed in" do
    before do
      render template: "components/_hero", locals: {hero_title: hero_title, status_message: status}
    end

    it "shows the status block" do
      expect(rendered).to have_css(".hero__status", text: status)
    end
  end

  context "when subtitle is passed in" do
    before do
      render template: "components/_hero", locals: {hero_title: hero_title, subtitle: subtitle}
    end

    it "shows the subtitle" do
      expect(rendered).to have_css(".hero__text", text: subtitle)
    end
  end

  context "when full_width is turned on" do
    before do
      render template: "components/_hero", locals: {hero_title: hero_title, full_width: true}
    end

    it "header width is overridden" do
      expect(rendered).to have_css(".hero__heading-wrapper--full-width", count: 1)
    end
  end
end
