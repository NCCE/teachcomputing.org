require "rails_helper"

RSpec.describe PrimaryDashboardCommunityActivityComponent, type: :component do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:activity) { create(:activity) }
  let(:in_progress_activity) { create(:activity, public_copy_description: "Community activity") }
  let(:complete_activity) { create(:activity, public_copy_description: "Community activity") }

  let(:programme_activities) { create_list(:programme_activity, 4) }
  let(:programme_activity_group) { create(:programme_activity_grouping, programme_activities:, community: true, programme:) }

  let(:in_progress_programme_activity) { create(:programme_activity, programme:, activity: in_progress_activity) }
  let(:in_progress_programme_activity_group) { create(:programme_activity_grouping, programme_activities: [in_progress_programme_activity], programme:) }

  let(:completed_programme_activity) { create(:programme_activity, programme:, activity: complete_activity) }
  let(:completed_programme_activity_group) { create(:programme_activity_grouping, programme_activities: [completed_programme_activity], programme:) }

  let(:multiple_programme_activities) { create_list(:programme_activity, 4, activity: in_progress_activity) }
  let(:multiple_programme_activity_group) { create(:programme_activity_grouping, programme_activities: multiple_programme_activities, programme:) }

  let(:completed_and_in_progress_programme_activity_group) {
    create(:programme_activity_grouping, programme_activities: [completed_programme_activity, in_progress_programme_activity], programme:)
  }

  let!(:achievement) { create(:in_progress_achievement, activity: in_progress_activity, user:) }
  let!(:completed_achievement) { create(:completed_achievement, activity: complete_activity) }
  let!(:multiple_achievements) { create_list(:in_progress_achievement, 3, activity: in_progress_activity) }

  context "with no activities" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render_inline(
        described_class.new(
          programme_activity_group:
        )
      )
    end

    it "renders no activities" do
      expect(page).to_not have_css(".primary-dashboard-community-activity__activity")
    end

    it "does not render the section titles" do
      expect(page).to_not have_css("h2", text: "Your completed activity")
      expect(page).to_not have_css("h2", text: "Complete your chosen activity")
    end

    it "renders the no activities heading" do
      expect(page).to have_css("h2", text: "Complete at least one activity")
    end

    it "renders the activity select dropdown" do
      expect(page).to have_select("activity")
    end

    it "has the correct count of activities in the select" do
      expect(page).to have_css("select[name='activity'] option", count: 5)
    end

    it "renders the activity select button in white" do
      expect(page).to have_css(".button--inverted")
    end
  end

  context "with only in progress activity" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user.achievements << achievement

      render_inline(
        described_class.new(
          programme_activity_group: in_progress_programme_activity_group
        )
      )
    end

    it "renders the activity" do
      expect(page).to have_css(".primary-dashboard-community-activity__activity", count: 1)
    end

    it "renders the in progress activity title" do
      expect(page).to have_css("h2", text: "Complete your chosen activity")
    end

    it "does not render the completed activity section title" do
      expect(page).to_not have_css("h2", text: "Your completed activity")
    end
  end

  context "with only a completed activity" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user.achievements << completed_achievement

      render_inline(
        described_class.new(
          programme_activity_group: completed_programme_activity_group
        )
      )
    end

    it "renders the activity" do
      expect(page).to have_css(".primary-dashboard-community-activity__activity", count: 1)
    end

    it "renders the completed activity section title" do
      expect(page).to have_css("h2", text: "Your completed activity")
    end

    it "does not render the in progress activity title" do
      expect(page).to_not have_css("h2", text: "Complete your chosen activity")
    end
  end

  context "with complete and chosen activities" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user.achievements << [achievement, completed_achievement]

      render_inline(
        described_class.new(
          programme_activity_group: completed_and_in_progress_programme_activity_group
        )
      )
    end

    it "renders the activities" do
      expect(page).to have_css(".primary-dashboard-community-activity__activity", count: 2)
    end

    it "renders the completed activity section title" do
      expect(page).to have_css("h2", text: "Your completed activity")
    end

    it "renders the in progress activity title" do
      expect(page).to have_css("h2", text: "Complete your chosen activity")
    end

    it "renders the activity title" do
      expect(page).to have_css("p", text: in_progress_activity.title)
      expect(page).to have_css("p", text: complete_activity.title)
    end

    it "renders the completed activity tick image" do
      expect(page).to have_css("img[src*='tick-green-dark']")
    end

    it "renders the activity remove icon" do
      expect(page).to have_css("img[src*='remove-activity-icon']")
    end

    it "renders the submit evidence button" do
      expect(page).to have_css(".govuk-button")
    end

    it "renders the activity selection list" do
      expect(page).to have_css("select")
    end

    it "renders the chose activity button" do
      expect(page).to have_css("a", text: "Choose activity")
    end

    it "does not render the choose at least one activity heading" do
      expect(page).to_not have_css("h2", text: "Complete at least one activity")
    end
  end

  context "with multiple activities" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      multiple_achievements.each do |achievement|
        user.achievements << achievement
      end

      render_inline(
        described_class.new(
          programme_activity_group: multiple_programme_activity_group
        )
      )
    end

    it "renders three activities" do
      expect(page).to have_css(".primary-dashboard-community-activity__activity-details", count: 4)
    end
  end
end
