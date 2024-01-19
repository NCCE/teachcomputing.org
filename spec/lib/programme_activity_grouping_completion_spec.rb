require "rails_helper"

RSpec.describe ProgrammeActivityGroupingCompletion do
  describe ".users_completed_credit_counted" do
    let!(:programme) { create(:programme) }
    let!(:programme_activity_grouping) { create(:programme_activity_groupings_credit_counted, required_credit_count: 60, programme:) }
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

        # All users have compeleted 60 credits
        users.each do |user|
          activities.first(3).each do |activity|
            create(:achievement, user:, activity:).transition_to :complete
          end
        end

        results = ProgrammeActivityGroupingCompletion.users_completed_credit_counted(
          programme_activity_grouping:,
          users:
        )

        expect(results.values).to eq [true, true, true]
      end
    end

    context "When only one of the users meets the completion requirements" do
      it "Should return true for just that user" do
        users = create_list(:user, 3)

        # The first user has compelted 60 credits
        activities.first(3).each do |activity|
          create(:achievement, user: users.first, activity:).transition_to :complete
        end

        # The first user has compelted 20 credits
        users.last(2).each do |user|
          create(:achievement, user:, activity: activities.first).transition_to :complete
        end

        results = ProgrammeActivityGroupingCompletion.users_completed_credit_counted(
          programme_activity_grouping:,
          users:
        )

        expect(results).to eq({
          users.first.id => true,
          users.second.id => false,
          users.third.id => false
        })
      end
    end
  end

  describe ".users_completed_completion_counted" do
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

        results = ProgrammeActivityGroupingCompletion.users_completed_completion_counted(
          programme_activity_grouping:,
          users:
        )

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

        results = ProgrammeActivityGroupingCompletion.users_completed_completion_counted(
          programme_activity_grouping:,
          users:
        )

        expect(results).to eq({
          users.first.id => true,
          users.second.id => false,
          users.third.id => false
        })
      end
    end
  end
end
