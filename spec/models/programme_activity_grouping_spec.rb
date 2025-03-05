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

    context "when the user has completed the an activity that is legacy" do
      before do
        programme_activity = programme_activity_groupings.first.programme_activities.first
        achievement = create(:achievement, user_id: user.id, activity_id: programme_activity.activity.id)
        achievement.transition_to(:complete)

        programme_activity.update(legacy: true)
      end

      it "returns true" do
        grouping = programme_activity_groupings.first
        expect(grouping.user_complete?(user)).to be true
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

  describe "#users_completed" do
    let!(:programme) { create(:programme) }
    let!(:programme_activity_grouping) { create(:programme_activity_grouping, required_for_completion: 3, programme:) }
    let!(:activities) do
      activities = create_list(:activity, 4, credit: 20)

      activities.each do |activity|
        create(
          :programme_activity,
          programme_activity_grouping: programme_activity_grouping,
          programme: programme,
          activity: activity
        )
      end

      activities
    end

    context "When all the users meet the completion requirements" do
      it "Should return true for all of the users" do
        users = create_list(:user, 3)

        # All users have compeleted 3 activities
        users.each do |user|
          activities.first(3).each do |activity|
            create(:achievement, user:, activity:).transition_to :complete
          end
        end

        results = programme_activity_grouping.users_completed(users:)

        expect(results.values).to eq [true, true, true]
      end
    end

    context "When only one of the users meets the completion requirements" do
      it "Should return true for just that user" do
        users = create_list(:user, 3)

        # The first user has compelted 3 activities
        activities.first(3).each do |activity|
          create(:achievement, user: users.first, activity:).transition_to :complete
        end

        # The first user has compelted 1 activity
        users.last(2).each do |user|
          create(:achievement, user:, activity: activities.first).transition_to :complete
        end

        results = programme_activity_grouping.users_completed(users:)

        expect(results).to eq({
          users.first.id => true,
          users.second.id => false,
          users.third.id => false
        })
      end
    end
  end
end
