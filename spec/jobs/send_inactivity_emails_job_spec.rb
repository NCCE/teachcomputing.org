require "rails_helper"

RSpec.describe SendInactivityEmailsJob, type: :job do
  let(:programme) { create(:i_belong) }
  let(:activity_understanding) { create(:activity) }
  let(:programme_activity_grouping_understanding) { create(:programme_activity_grouping, programme:, required_for_completion: 1, sort_key: 2) }
  let!(:programme_activity_understanding) { create(:programme_activity, programme:, activity: activity_understanding, programme_activity_grouping: programme_activity_grouping_understanding) }
  let(:activity_resources1) { create(:activity) }
  let(:activity_resources2) { create(:activity) }
  let(:activity_resources3) { create(:activity) }
  let(:programme_activity_grouping_resources) { create(:programme_activity_grouping, programme:, required_for_completion: 3, sort_key: 3) }
  let!(:programme_activity_resources1) { create(:programme_activity, programme:, activity: activity_resources1, programme_activity_grouping: programme_activity_grouping_resources) }
  let!(:programme_activity_resources2) { create(:programme_activity, programme:, activity: activity_resources2, programme_activity_grouping: programme_activity_grouping_resources) }
  let!(:programme_activity_resources3) { create(:programme_activity, programme:, activity: activity_resources3, programme_activity_grouping: programme_activity_grouping_resources) }
  let(:activity_engagement) { create(:activity) }
  let(:programme_activity_grouping_engagement) { create(:programme_activity_grouping, programme:, required_for_completion: 1, sort_key: 4) }
  let!(:programme_activity_engagement) { create(:programme_activity, programme:, activity: activity_engagement, programme_activity_grouping: programme_activity_grouping_engagement) }

  describe "#perform" do
    describe "users with no activities" do
      let(:user_no_activities) { create(:user) }
      let!(:user_no_activities_upe) { create(:user_programme_enrolment, user: user_no_activities, programme:, created_at: 2.months.ago) }

      it "should send emails for no activity users" do
        expect {
          described_class.perform_now
        }.to have_enqueued_mail(IBelongMailer, :inactive_not_completed_any_sections).with(a_hash_including(params: {user: user_no_activities}))
      end
    end

    describe "user without resources" do
      let(:user_no_resources) { create(:user) }
      let(:user_no_resources_upe) { create(:user_programme_enrolment, user: user_no_resources, programme:, created_at: 2.months.ago) }

      before do
        user_no_resources_upe
        create(:completed_achievement, activity: activity_engagement, user: user_no_resources, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_understanding, user: user_no_resources, created_at: 2.months.ago, updated_at: 2.months.ago)
      end

      it "should send emails for missing resources" do
        expect {
          described_class.perform_now
        }.to have_enqueued_mail(IBelongMailer, :inactive_everything_but_access_resources).with(a_hash_including(params: {user: user_no_resources}))
      end
    end

    describe "user without undestanding factors" do
      let(:user_no_understanding) { create(:user) }
      let(:user_no_understanding_upe) { create(:user_programme_enrolment, user: user_no_understanding, programme:, created_at: 2.months.ago) }

      before do
        user_no_understanding_upe
        create(:completed_achievement, activity: activity_resources1, user: user_no_understanding, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_resources2, user: user_no_understanding, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_resources3, user: user_no_understanding, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_engagement, user: user_no_understanding, created_at: 2.months.ago, updated_at: 2.months.ago)
      end

      it "should send emails for missing understanding" do
        expect {
          described_class.perform_now
        }.to have_enqueued_mail(IBelongMailer, :inactive_everything_but_understanding_factors).with(a_hash_including(params: {user: user_no_understanding}))
      end
    end

    describe "user without engagement" do
      let(:user_no_engagement) { create(:user) }
      let(:user_no_engagement_upe) { create(:user_programme_enrolment, user: user_no_engagement, programme:, created_at: 2.months.ago) }

      before do
        user_no_engagement_upe
        create(:completed_achievement, activity: activity_resources1, user: user_no_engagement, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_resources2, user: user_no_engagement, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_resources3, user: user_no_engagement, created_at: 2.months.ago, updated_at: 2.months.ago)
        create(:completed_achievement, activity: activity_understanding, user: user_no_engagement, created_at: 2.months.ago, updated_at: 2.months.ago)
      end

      it "should send emails for missing engagement" do
        expect {
          described_class.perform_now
        }.to have_enqueued_mail(IBelongMailer, :inactive_everything_but_increase_engagement).with(a_hash_including(params: {user: user_no_engagement}))
      end
    end

    describe "user with only one section complete" do
      let(:user_one_section) { create(:user) }
      let(:user_one_section_upe) { create(:user_programme_enrolment, user: user_one_section, programme:, created_at: 2.months.ago) }

      before do
        user_one_section_upe
        create(:completed_achievement, activity: activity_engagement, user: user_one_section, created_at: 2.months.ago, updated_at: 2.months.ago)
      end

      it "should send emails for one section" do
        expect {
          described_class.perform_now
        }.to have_enqueued_mail(IBelongMailer, :inactive_only_completed_one_section).with(a_hash_including(params: {user: user_one_section}))
      end
    end
  end
end
