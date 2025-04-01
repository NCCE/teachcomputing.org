require "rails_helper"

RSpec.describe("certificates/pathways/show", type: :view) do
  let(:recommended_title) { "Recommened activity" }
  let(:not_recommended_title) { "No need activity" }
  let(:programme) { create(:secondary_certificate) }
  let(:user) { create(:user) }
  let!(:cpd_group) { create(:programme_activity_grouping, community: false, programme:) }
  let!(:community_group) { create(:programme_activity_grouping, community: true, programme:) }
  let(:pathway) { create(:pathway, programme:, enrol_copy: ["foo", "bar"]) }
  let!(:pathway_activities) { create_list(:pathway_activity, 2, pathway:) }
  let!(:not_recommened_community_activity) {
    act = create(:activity, :community, title: not_recommended_title)
    create(:programme_activity, activity: act, programme:, programme_activity_grouping: community_group)
  }
  let(:recommended_community_activity) {
    act = create(:activity, :community, title: recommended_title, public_copy_title_url: "https://teachcomputing.org/certificates/secondary-certificate")
    create(:programme_activity, activity: act, programme:, programme_activity_grouping: community_group)
    create(:pathway_activity, pathway:, activity: act)
    act
  }

  let(:recommended_community_activity_without_link) {
    act = create(:activity, :community, title: recommended_title)
    create(:programme_activity, activity: act, programme:, programme_activity_grouping: community_group)
    create(:pathway_activity, pathway:, activity: act)
    act
  }

  before do
    stub_course_templates
    assign(:programme, programme)
    assign(:current_user, user)
    assign(:pathway, pathway)

    assign(:recommended_activities, pathway_activities)
    assign(:cpd_group, cpd_group)
    assign(:community_groups, [community_group])
  end

  context "with community title link" do
    before do
      assign(:recommended_community_activities, [recommended_community_activity])
      assign(:recommended_community_activity_ids, [recommended_community_activity.id])
      render
    end

    it "should show pathway description" do
      expect(rendered).to have_css(".govuk-body-s", text: pathway.description)
    end

    it "should render recommmend courses" do
      expect(rendered).to have_css(".ncce-pathway-courses__link", count: 3)
    end

    it "should display the title of recommended activity" do
      expect(rendered).to have_link(recommended_title, href: "https://teachcomputing.org/certificates/secondary-certificate")
    end
  end

  context "without community title link" do
    before do
      assign(:recommended_community_activities, [recommended_community_activity_without_link])
      assign(:recommended_community_activity_ids, [recommended_community_activity_without_link.id])
      render
    end

    it "should show pathway description" do
      expect(rendered).to have_css(".govuk-body-s", text: pathway.description)
    end

    it "should render recommmend courses" do
      expect(rendered).to have_css(".ncce-pathway-courses__link", count: 2)
    end

    it "should display the title of recommended activity" do
      expect(rendered).to have_text(recommended_title)
    end
  end
end
