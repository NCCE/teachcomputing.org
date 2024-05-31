require "rails_helper"

RSpec.describe Pathway, type: :model do
  let(:pathway) { create(:pathway) }

  describe "associations" do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to have_many(:user_programme_enrolments) }
    it { is_expected.to have_many(:pathway_activities) }
  end

  describe ".ordered_by_programme" do
    it 'returns pathways ordered by the "order" column value' do
      prog = create(:cs_accelerator)
      last_pathway = create(:pathway, order: 3, programme: prog)
      first_pathway = create(:pathway, order: 1, programme: prog)
      middle_pathway = create(:pathway, order: 2, programme: prog)
      expect(described_class.ordered_by_programme("subject-knowledge")).to eq([first_pathway, middle_pathway,
        last_pathway])
    end

    it "only shows pathways from the relevant programme" do
      prog = create(:cs_accelerator)
      prog_2 = create(:primary_certificate)
      last_pathway = create(:pathway, order: 3, programme: prog)
      create(:pathway, order: 1, programme: prog_2)
      middle_pathway = create(:pathway, order: 2, programme: prog)
      expect(described_class.ordered_by_programme("subject-knowledge")).to eq([middle_pathway,
        last_pathway])
    end
  end

  describe ".not_legacy" do
    let!(:legacy) { create(:pathway, legacy: true) }
    let!(:not_legacy) { create(:pathway) }

    it "returns only pathways which have legacy: false" do
      expect(described_class.not_legacy.to_a).to eq [not_legacy]
    end
  end

  describe "#has_improvement_copy?" do
    context "when neither improvement bulletse and improvemenet_cta are present" do
      it "returns false" do
        expect(pathway.has_improvement_copy?).to be false
      end
    end

    context "when only improvement bullets are present" do
      it "returns false" do
        pathway.improvement_bullets = [["foo"]]

        expect(pathway.has_improvement_copy?).to be false
      end
    end

    context "when only improvemenet_cta are present" do
      it "returns false" do
        pathway.improvement_cta = "asdf"

        expect(pathway.has_improvement_copy?).to be false
      end
    end

    context "when both improvement bullets and improvemenet_cta are present" do
      it "returns true" do
        pathway.improvement_bullets = [["foo"]]
        pathway.improvement_cta = "asdf"

        expect(pathway.has_improvement_copy?).to be true
      end
    end
  end

  describe "#recommended_activities" do
    it "returns pathway_activities not set as supplementary" do
      recommended = create_list(:pathway_activity, 3, pathway: pathway, supplementary: false)
      create_list(:pathway_activity, 3, pathway: pathway, supplementary: true)
      expect(pathway.recommended_activities).to match_array(recommended)
    end
  end

  describe "#recommended_activities_for_user" do
    it "returns pathway_activities not set as supplementary where user is not taking course" do
      user = create(:user)
      activity = create(:activity)
      create(:achievement, user: user, activity: activity)
      create(:pathway_activity, pathway: pathway, activity: activity, supplementary: false)
      recommended = create_list(:pathway_activity, 3, pathway: pathway, supplementary: false)
      expect(pathway.recommended_activities_for_user(user)).to match_array(recommended)
    end
  end
end
