require "rails_helper"

RSpec.describe CpdCourseComponent, type: :component do
  let(:user) { create(:user) }
  let(:stem_activity_code) { "CPXXX" }
  let(:activity) { create(:activity, stem_activity_code:) }
  let(:achievement) { nil }
  let(:last_margin) { true }

  before do
    stub_course_templates
    stub_duration_units

    achievement

    render_inline(
      described_class.new(
        current_user: user,
        activity:,
        last_margin:
      )
    )
  end

  context "when last_margin is true" do
    it "shouldn't have the no-last-margin class" do
      expect(page).not_to have_css(".courses__course-no-last-margin")
    end
  end

  context "when last_margin is false" do
    let(:last_margin) { false }

    it "shouldn't have the no-last-margin class" do
      expect(page).to have_css(".ncce-pathway-courses__course-no-last-margin")
    end
  end

  context "when stem_activity_code is not found" do
    it "shouldn't display the date" do
      expect(page).not_to have_css(".icon-clock")
    end
  end

  context "when stem_activity_code is found" do
    let(:stem_activity_code) { "CP228" }
    it "shouldn't display the date" do
      expect(page).to have_css(".icon-clock")
    end
  end

  context "when there is no achievement found" do
    it "shouldn't display a status" do
      expect(page).not_to have_css(".ncce-pathway-courses__status")
    end
  end

  context "when there is an in progress achievement" do
    let(:achievement) { create(:achievement, user:, activity:) }

    it "should display an in progress status" do
      expect(page).to have_css(".ncce-pathway-courses__status", text: "In progress")
    end
  end

  context "when there is no stem_activity_code" do
    let(:stem_activity_code) { nil }

    it "should not display the link" do
      expect(page).not_to have_css(".ncce-link")
    end
  end

  context "when there is a stem_activity_code" do
    it "should display the link" do
      expect(page).to have_css(".ncce-link")
    end
  end

  context "when activity has been replaced by" do
    context "but still in achiever" do
      let(:replaced_by_activity) { create(:activity) }
      let(:activity) { create(:activity, stem_activity_code: "CP228", replaced_by: replaced_by_activity) }

      it "should display the link" do
        expect(page).to have_text(activity.title)
      end
    end

    context "not in achiever" do
      let(:replaced_by_activity) { create(:activity, stem_activity_code: "CP288") }
      let(:activity) { create(:activity, stem_activity_code:, replaced_by: replaced_by_activity) }

      it "should display the link" do
        expect(page).to have_text(replaced_by_activity.title)
      end
    end
  end
end
