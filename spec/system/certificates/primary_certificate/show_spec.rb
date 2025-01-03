require "rails_helper"

RSpec.describe("Primary certificate page") do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:programme) { create(:primary_certificate) }
  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme:) }
  let!(:community_programme_activity_grouping) { create(:programme_activity_grouping, programme:, community: true) }
  let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  let(:activities) { create_list(:activity, 3, :community, public_copy_description: "Activity description") }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    allow_any_instance_of(ActionController::Base).to receive(:protect_against_forgery?).and_return(true)

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

  it "adds the selected activity to the dashboard from the select" do
    activity = programme.programme_activity_groupings.community.first.activities.first
    visit primary_certificate_path

    select activity.title, from: "activity"
    click_on "Choose activity"

    expect(page).to have_css(".primary-dashboard-community-activity__activity-details")
    expect(page).to have_text(activity.title)
    expect(page).to have_text(activity.public_copy_description)
  end

  it "removes the chosen activity when discard image is clicked" do
    create(:achievement, user:, activity: programme.programme_activity_groupings.community.first.activities.first)
    visit primary_certificate_path

    within ".primary-dashboard-community-activity__activity-details-title" do
      find("a").click
    end

    expect(page).to_not have_css(".primary-dashboard-community-activity__activity-details")
  end
end
