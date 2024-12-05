require "rails_helper"

RSpec.describe("certificates/primary_certificate/show", type: :view) do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }

  let(:user_courses) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, community: false, programme: primary_certificate) }
  let(:community_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, community: true, programme: primary_certificate) }

  before do
    assign(:programme, primary_certificate)
    assign(:current_user, user)
    assign(:user_courses, user_courses)
    assign(:community_groups, community_groups)

    allow_any_instance_of(AuthenticationHelper)
      .to receive(:current_user).and_return(user)

    stub_strapi_aside_section("primary-certificate-need-help")
    stub_strapi_aside_section("primary-dashboard-cpd-section")

    render
  end

  it "renders the page title component" do
    expect(rendered).to have_css(".page-title__wrapper")
  end

  it "renders the progress component" do
    expect(rendered).to have_css(".progress-bar-component")
  end

  it "renders the user courses component" do
    expect(rendered).to have_css(".user-programme-course-bookings-with-asides")
  end

  it "renders the user programme activities components" do
    expect(rendered).to have_css(".user-programme-activities-with-asides", count: 2)
  end
end
