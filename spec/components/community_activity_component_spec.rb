require "rails_helper"

RSpec.describe CommunityActivityComponent, type: :component do
  let(:activity) { create(:activity, :community) }
  let(:bookable_community_activity) { create(:activity, :community_bookable) }
  let(:incomplete_achievement) { create(:achievement, :community) }
  let(:completed_achievement) { create(:completed_achievement) }
  let(:activity_with_options) {
    create(:activity, :community_no_evidence, public_copy_submission_options: [
      {
        title: "Option 1",
        redirect: "https://teachcomputing.org/option1",
        slug: "option-1",
        redownload: true
      },
      {
        title: "Option 2",
        redirect: "https://teachcomputing.org/option2",
        slug: "option-2",
        redownload: true
      }
    ])
  }
  let(:completed_option_achievement) { create(:completed_achievement, submission_option: "option-2") }
  let(:activity_with_no_redownload) {
    create(:activity, :community_no_evidence, public_copy_submission_options: [
      {
        title: "No Redownload",
        redirect: "https://teachcomputing.org/no-redownload",
        slug: "no-redownload",
        redownload: false
      }
    ])
  }
  let(:completed_no_redownload_achievement) { create(:completed_achievement, submission_option: "no-redownload") }

  describe "with standard activity" do
    describe "with an incomplete achievement" do
      before do
        render_inline(
          described_class.new(
            achievement: incomplete_achievement,
            activity:,
            class_name: "custom_css_class"
          )
        )
      end

      it "does not render the complete class" do
        expect(page).not_to have_css(".community-activity-component__objective-text--complete")
      end

      it "renders with the expected objective" do
        expect(page).to have_css(".community-activity-component__objective-text", text: "Community Activity")
      end

      it "renders the evidence button" do
        expect(page).to have_button("Submit evidence")
      end

      it "has the buttons to self verify" do
        expect(page).to have_css("button", text: "Submit evidence")
      end

      it "renders a description" do
        expect(page).to have_css(".community-activity-component__description", text: "this is a community activity")
      end

      it "renders the custom class" do
        expect(page).to have_css(".custom_css_class")
      end

      it "renders a booking link" do
        expect(page).not_to have_link("Book a course")
      end

      context "with an activity with no self verification info" do
        let(:activity) { create(:activity, :community, self_verification_info: nil, public_copy_evidence: nil) }

        it "does not render the complete class" do
          expect(page).not_to have_css(".community-activity-component__objective-text--complete")
        end

        it "renders with the expected objective" do
          expect(page).to have_css(".community-activity-component__objective-text", text: "Community Activity")
        end

        it "renders the mark complete button" do
          expect(page).to have_button("Mark complete")
        end

        it "renders a description" do
          expect(page).to have_css(".community-activity-component__description", text: "this is a community activity")
        end

        it "renders the custom class" do
          expect(page).to have_css(".custom_css_class")
        end

        it "renders a booking link" do
          expect(page).not_to have_link("Book a course")
        end
      end
    end

    describe "with a booking_programme_slug" do
      before do
        render_inline(
          described_class.new(
            achievement: incomplete_achievement,
            activity: bookable_community_activity,
            class_name: "custom_css_class"
          )
        )
      end

      it "renders a booking link" do
        expect(page).to have_link("Book a course", href: "/courses?certificate=subject-knowledge")
      end
    end

    describe "with a completed achievement" do
      before do
        render_inline(
          described_class.new(
            achievement: completed_achievement,
            activity: activity,
            class_name: "custom_css_class"
          )
        )
      end

      it "renders the complete class" do
        expect(page).to have_css(".community-activity-component__completed-badge", text: "Completed")
      end

      it "does not render the evidence button" do
        expect(page).not_to have_button("Submit evidence")
      end
    end
  end

  describe "with activity with submission options" do
    describe "with redownload endabled" do
      describe "with an incomplete achievement" do
        before do
          render_inline(
            described_class.new(
              achievement: incomplete_achievement,
              activity: activity_with_options
            )
          )
        end

        it "should have two buttons" do
          expect(page).to have_css(".govuk-button", text: "Option 1")
          expect(page).to have_css(".govuk-button", text: "Option 2")
        end
      end

      describe "with an complete achievement" do
        before do
          render_inline(
            described_class.new(
              achievement: completed_option_achievement,
              activity: activity_with_options
            )
          )
        end

        it "should have one button" do
          expect(page).to have_css(".govuk-button", text: "Option 1")
        end

        it "should have one completed badge" do
          expect(page).to have_css(".community-activity-component__completed-badge", count: 1)
        end

        it "should have redownload link" do
          expect(page).to have_link("Re-download option 2", href: "https://teachcomputing.org/option2")
        end
      end
    end

    describe "without redownload" do
      describe "with an incomplete achievement" do
        before do
          render_inline(
            described_class.new(
              achievement: incomplete_achievement,
              activity: activity_with_no_redownload
            )
          )
        end

        it "should have two buttons" do
          expect(page).to have_css(".govuk-button", text: "No Redownload")
        end
      end

      describe "with an complete achievement" do
        before do
          render_inline(
            described_class.new(
              achievement: completed_no_redownload_achievement,
              activity: activity_with_no_redownload
            )
          )
        end

        it "should have one completed badge" do
          expect(page).to have_css(".community-activity-component__completed-badge", count: 1)
        end

        it "should not have redownload link" do
          expect(page).not_to have_link("Redownload No Redownload", href: "https://teachcomputing.org/no-redownload")
        end
      end
    end
  end
end
