require "rails_helper"

RSpec.describe Certificates::PathwaysController do
  let(:recommened_title) { "Recommened activity" }
  let(:not_recommened_title) { "No need activity" }
  let(:programme) { create(:programme) }
  let!(:cpd_group) { create(:programme_activity_grouping, community: false, programme:) }
  let!(:community_group) { create(:programme_activity_grouping, community: true, programme:) }
  let(:pathway) { create(:pathway, programme:, enrol_copy: ["foo", "bar"]) }
  let!(:pathway_activites) { create_list(:pathway_activity, 2, pathway:)}
  let!(:not_recommened_community_activity) {
    act = create(:activity, :community, title: not_recommened_title)
    create(:programme_activity, activity: act, programme:, programme_activity_grouping: community_group)
  }
  let!(:recommened_community_activity) {
    act = create(:activity, :community, title: recommened_title)
    create(:programme_activity, activity: act, programme:, programme_activity_grouping: community_group)
    create(:pathway_activity, pathway:, activity: act)
  }

  describe "GET #show" do
    before do
      stub_course_templates
      get pathway_path(slug: pathway.slug)
    end

    it "shows the page" do
      expect(response).to render_template("certificates/pathways/show")
    end
  end
end
