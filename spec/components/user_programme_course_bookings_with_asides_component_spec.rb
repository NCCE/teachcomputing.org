require "rails_helper"

RSpec.describe UserProgrammeCourseBookingsWithAsidesComponent, type: :component do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, stem_activity_code: "CP100", category: :online) }
  let(:activity_two) { create(:activity, stem_activity_code: "CP228") }
  let(:programme) { create(:primary_certificate) }
  let(:achievement) { create(:achievement, user:) }
  let!(:courses) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 2, community: false, programme:) }
  let!(:programme_activity) { create(:programme_activity, programme:, activity:, programme_activity_grouping: courses.first) }
  let!(:programme_activity_two) { create(:programme_activity, programme:, activity: activity_two, programme_activity_grouping: courses.first) }
  let(:user_achievement) { create(:achievement, user:, activity:) }
  let(:completed_user_achievement) { create(:completed_achievement, user:, activity: activity_two) }

  context "with no user courses" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)

      stub_strapi_aside_section("test-aside")

      render_inline(
        described_class.new(
          programme: programme,
          aside_slug: "test-aside"
        )
      )
    end

    it "renders the section title" do
      expect(page).to have_css("h2", text: "Step one: CPD courses")
    end

    it "does not render any courses" do
      expect(page).to_not have_css(".user-programme-course-bookings-with-asides__course-wrapper")
    end

    it "renders the explore courses button" do
      expect(page).to have_css(".govuk-button", text: "Explore courses")
    end

    it "does not render the aside" do
      expect(page).to_not have_css(".aside-component")
    end
  end

  context "with completed course" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)

      completed_user_achievement

      stub_course_templates
      stub_duration_units
      stub_strapi_aside_section("test-aside")

      render_inline(
        described_class.new(
          programme: programme,
          aside_slug: "test-aside"
        )
      )
    end

    it "renders the booked courses title" do
      expect(page).to have_css("h2", text: "Completed courses")
    end

    it "renders the course details" do
      expect(page).to have_css(".user-programme-course-bookings-with-asides__course-wrapper", count: 1)
    end

    it "renders the aside" do
      expect(page).to have_css(".aside-component")
    end

    it "renders the course title and link" do
      expect(page).to have_css("a", text: completed_user_achievement.activity.title)
    end

    it "renders the course icon" do
      expect(page).to have_css("[class^='icon']")
    end

    it "renders the course duration" do
      expect(page).to have_css(".icon-clock")
    end
  end

  context "with in progress course" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)

      user_achievement

      stub_course_templates
      stub_duration_units
      stub_strapi_aside_section("test-aside")

      render_inline(
        described_class.new(
          programme: programme,
          aside_slug: "test-aside"
        )
      )
    end

    it "renders the booked courses title" do
      expect(page).to have_css("h2", text: "Booked courses")
    end

    it "renders the course details" do
      expect(page).to have_css(".user-programme-course-bookings-with-asides__course-wrapper", count: 1)
    end

    it "renders the aside" do
      expect(page).to have_css(".aside-component")
    end

    it "renders the online course icon" do
      expect(page).to have_css(".icon-online")
    end

    it "renders the completed tick image" do
      expect(page).to have_css("img[src*='activity-complete-icon']")
    end
  end

  context "with completed and in progress courses and no aside" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)

      user_achievement
      completed_user_achievement

      stub_course_templates
      stub_duration_units

      render_inline(
        described_class.new(
          programme: programme,
          aside_slug: nil
        )
      )
    end

    it "renders the booked and completed courses title" do
      expect(page).to have_css("h2", text: "Booked courses")
      expect(page).to have_css("h2", text: "Completed courses")
    end

    it "renders the course details" do
      expect(page).to have_css(".user-programme-course-bookings-with-asides__course-wrapper", count: 2)
    end

    it "renders the aside" do
      expect(page).to_not have_css(".aside-component")
    end

    it "renders the completed tick image" do
      expect(page).to have_css("img[src*='activity-complete-icon']")
    end

    it "does not render the aside component" do
      expect(page).to_not have_css(".aside-component")
    end

    it "renders the face to face icon" do
      expect(page).to have_css(".icon-map-pin")
    end
  end
end