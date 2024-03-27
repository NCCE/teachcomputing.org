require "rails_helper"

RSpec.describe CourseActivityComponent, type: :component do
  let(:face_to_face_achievement) { create(:completed_achievement, :face_to_face) }
  let(:remote_achievement) { create(:achievement, :remote_no_activity_code) }
  let(:online_activity) { create(:activity, :online, title: "Online activity") }
  let(:online_achievement) { create(:achievement, :online, activity: online_activity) }

  describe "with no achievements" do
    before do
      render_inline(
        described_class.new(
          objective: "I describe things",
          booking: {
            path: "https://example.com/book",
            tracking_label: "some label"
          },
          achievements: nil,
          class_name: "custom_css_class",
          tracking_category: "some category"
        )
      )
    end

    it "does not render the complete class" do
      expect(page).not_to have_css(".course-activity-component__objective-text--complete")
    end

    it "renders with the expected objective" do
      expect(page).to have_css(".course-activity-component__objective-text", text: "I describe things")
    end

    it "renders the expected link" do
      expect(page).to have_link("Book a course", href: "https://example.com/book")
    end

    it "renders the expected tracking data" do
      link = page.find("a", text: "Book a course")
      expect(link["data-event-label"]).to eq("some label")
      expect(link["data-event-category"]).to eq("some category")
    end

    it "renders the custom class" do
      expect(page).to have_css(".custom_css_class")
    end
  end

  describe "with only incomplete achievements" do
    before do
      render_inline(
        described_class.new(
          objective: "I describe things",
          booking: {
            path: "https://example.com/book"
          },
          achievements: [remote_achievement, online_achievement]
        )
      )
    end

    it "does not render the complete class" do
      expect(page).not_to have_css(".course-activity-component__objective-text--complete")
    end
  end

  describe "with various categories and a completed achievement" do
    before do
      render_inline(
        described_class.new(
          objective: "I describe things",
          booking: {
            path: "https://example.com/book"
          },
          achievements: [face_to_face_achievement, remote_achievement, online_achievement]
        )
      )
    end

    it "renders a list of achievements" do
      expect(page).to have_css(".course-activity-component__course", count: 3)
    end

    it "renders the complete class" do
      expect(page).to have_css(".course-activity-component__objective-text--complete")
    end

    context "with a face to face achievement" do
      let(:element) { page.find(".course-activity-component__course", text: "Face to face activity") }

      it "has the expected link" do
        expect(element).to have_link(
          "Face to face activity", href: "/courses/#{face_to_face_achievement.activity.stem_activity_code}/#{face_to_face_achievement.activity.slug}"
        )
      end

      it "has the expected icon" do
        expect(element).to have_css(".icon-map-pin", text: "Face to face")
      end

      it "has the expected status" do
        expect(element).to have_css(".ncce-courses__tag", text: "Completed")
      end
    end

    context "with a remote achievement" do
      let(:element) { page.find(".course-activity-component__course", text: "Remote activity") }

      it "has a link" do
        expect(element).not_to have_link("Remote activity")
      end

      it "has the expected icon" do
        expect(element).to have_css(".icon-remote", text: "Remote")
      end

      it "has the expected status" do
        expect(element).to have_css(".ncce-courses__tag", text: "In progress")
      end
    end

    context "with an online achievement" do
      let(:element) { page.find(".course-activity-component__course", text: "Online activity") }

      it "has a link" do
        expect(element).to have_link("Online activity")
      end

      it "has the expected icon" do
        expect(element).to have_css(".icon-online", text: "Online")
      end

      it "has the expected status" do
        expect(element).to have_css(".ncce-courses__tag", text: "In progress")
      end
    end
  end
end
