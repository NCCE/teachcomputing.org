require "rails_helper"

RSpec.describe("Primary certificate page") do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:programme) { create(:primary_certificate) }
  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme:) }
  let!(:community_programme_activity_grouping) { create(:programme_activity_grouping, programme:, community: true) }
  let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  let(:activities) { create_list(:activity, 3, :community) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    mock_data = Cms::Mocks::Programme.generate_raw_data(slug: programme.slug)
    stub_strapi_programme(programme.slug, programme: mock_data)
    stub_strapi_aside_section("primary-certificate-need-help")
    stub_strapi_aside_section("primary-dashboard-cpd-section")

    activities.each_with_index do |activity, index|
      activity.update(title: "Activity #{index + 1}")
      create(:programme_activity,
        programme_activity_grouping: community_programme_activity_grouping,
        programme:,
        activity:)
    end
  end

  it "creates a user achievement when activity is selected" do
    activity = programme.programme_activity_groupings.community.first.activities.first
    visit primary_certificate_path

    expect {
      select activity.title, from: "activity"
      sleep 1
      click_on "Choose activity"
      sleep 5
    }.to change { user.reload.achievements.count }.by(1)

    latest_achievement = user.achievements.last
    expect(latest_achievement.activity_id).to eq(activity.id)
  end
end
