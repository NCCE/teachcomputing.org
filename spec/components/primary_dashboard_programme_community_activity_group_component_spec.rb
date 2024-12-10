require "rails_helper"

RSpec.describe PrimaryDashboardProgrammeCommunityActivityGroupComponent, type: :component do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:programme_activity_group) { create(:programme_activity_grouping, :with_activities, community: true, programme:) }
  let(:complete_programme_activity_group) { create(:programme_activity_grouping, required_for_completion: 0) }

  context "when group is not complete" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      render_inline(
        described_class.new(
          title: "Title",
          programme_activity_group:,
          current_user: user,
          aside_slug: nil
        )
      )
    end

    it "renders the title" do
      expect(page).to have_css("h2", text: "Title")
    end

    it "renders the programme activity component" do
      expect(page).to have_css(".primary-dashboard-community-activity")
    end

    it "does not render an aside" do
      expect(page).to_not have_css(".aside-component")
    end
  end

  context "with an aside" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      stub_strapi_aside_section("test-aside")

      render_inline(
        described_class.new(
          title: "Title",
          programme_activity_group:,
          current_user: user,
          aside_slug: "test-aside"
        )
      )
    end

    it "renders an aside" do
      expect(page).to have_css(".aside-component")
    end
  end

  context "when the activity group is complete" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      stub_strapi_aside_section("test-aside")

      render_inline(
        described_class.new(
          title: "Title",
          programme_activity_group: complete_programme_activity_group,
          current_user: user,
          aside_slug: "test-aside"
        )
      )
    end

    it "renders the completed tick image" do
      expect(page).to have_css("img[src*='activity-complete-icon']")
    end
  end
end
