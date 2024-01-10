require "rails_helper"

RSpec.describe ProgrammeActivityGrouping, type: :model do
  let(:programme) { create(:programme) }
  let(:programme_activity_grouping) { create(:programme_activity_grouping) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 3, :with_activities, programme: programme) }
  let(:user) { create(:user) }

  subject { programme_activity_grouping }

  it_behaves_like "plays programme objective role"
  it_behaves_like "plays programme objective progress bar role"

  describe "associations" do
    it "has_many programme_activities" do
      expect(programme_activity_grouping).to have_many(:programme_activities)
    end

    it "belongs to programme" do
      expect(programme_activity_grouping).to belong_to(:programme)
    end
  end

  describe "#user_complete?" do
    before do
      programme_activity_groupings
      user
    end

    context "when the user has not completed the required number of activities" do
      it "returns false" do
        grouping = programme_activity_groupings.first
        expect(grouping.user_complete?(user)).to be false
      end
    end

    context "when the user has completed the required number of activities" do
      before do
        achievement = create(:achievement, user_id: user.id, activity_id: programme_activity_groupings.first.programme_activities.first.activity.id)
        achievement.transition_to(:complete)
      end

      it "returns true" do
        grouping = programme_activity_groupings.first
        expect(grouping.user_complete?(user)).to be true
      end
    end
  end

  describe "#formatted_title" do
    let(:group) { create(:programme_activity_grouping, required_for_completion:, title:) }
    let(:required_for_completion) { 1 }
    let!(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping: group) }
    let(:title) { "Encourage girls into computer science" }

    context "when the count for required for completion is not equal to the quantity of activities" do
      context "when the count required for completion is one" do
        it "should state the quantity required for completion with correct singlars" do
          expect(group.formatted_title).to end_with "by completing <strong>at least one</strong> activity"
        end
      end

      context "when the count required for completion is two" do
        let(:required_for_completion) { 2 }

        it "should state the quantity required for completion with correct plurals" do
          expect(group.formatted_title).to end_with "by completing <strong>at least two</strong> activities"
        end
      end
    end

    context "when the count for required for completion is equal to the quantity of activities" do
      let(:required_for_completion) { 3 }

      it "shouldn't state how many are required for completion" do
        expect(group.formatted_title).to eq "Encourage girls into computer science"
      end
    end

    context "when the count for required completion is not equal to the quantity of non-coming-soon activities" do
      it "should state the quantity required for completion with correct singlars" do
        programme_activities.last.activity.update(coming_soon: true)

        expect(group.formatted_title).to end_with "by completing <strong>at least one</strong> activity"
      end
    end

    context "when the count for required completion is equal to the quantity of non-coming-soon activities" do
      let(:required_for_completion) { 2 }

      it "should state the quantity required for completion with correct singlars" do
        programme_activities.last.activity.update(coming_soon: true)

        expect(group.formatted_title).to end_with "Encourage girls into computer science"
      end
    end
  end

  describe ".community" do
    let!(:community) { create(:programme_activity_grouping, community: true) }
    let!(:not_community) { create(:programme_activity_grouping) }

    it "should return just community PAGs" do
      expect(described_class.community.to_a).to eq [community]
    end
  end

  describe ".not_community" do
    let!(:community) { create(:programme_activity_grouping, community: true) }
    let!(:not_community) { create(:programme_activity_grouping) }

    it "should return just not community PAGs" do
      expect(described_class.not_community.to_a).to eq [not_community]
    end
  end
end
