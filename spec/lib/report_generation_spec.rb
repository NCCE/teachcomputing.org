require "rails_helper"

RSpec.describe ReportGeneration do
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:primary_programme_activity_grouping) { create(:programme_activity_groupings_credit_counted, sort_key: 1, required_credit_count: 60, programme: primary_certificate) }
  let!(:primary_activities) do
    activities = create_list(:activity, 4, credit: 20)

    activities.each do |activity|
      create(
        :programme_activity,
        programme_activity_grouping: primary_programme_activity_grouping,
        programme: primary_certificate,
        activity: activity
      )
    end

    activities
  end
  let!(:primary_programme_first_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 2, community: true, programme: primary_certificate) }
  let!(:primary_programme_second_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 3, community: true, programme: primary_certificate) }

  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:secondary_programme_activity_grouping) { create(:programme_activity_groupings_credit_counted, sort_key: 2, required_credit_count: 60, programme: secondary_certificate) }
  let!(:secondary_activities) do
    activities = create_list(:activity, 4, credit: 20)

    activities.each do |activity|
      create(
        :programme_activity,
        programme_activity_grouping: secondary_programme_activity_grouping,
        programme: secondary_certificate,
        activity: activity
      )
    end

    activities
  end
  let!(:secondary_programme_first_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 3, community: true, programme: secondary_certificate) }
  let!(:secondary_programme_second_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 4, community: true, programme: secondary_certificate) }

  let!(:i_belong) { create(:i_belong) }
  let!(:i_belong_programme_activity_grouping) { create(:programme_activity_grouping, sort_key: 1, programme: i_belong) }
  let!(:i_belong_activities) do
    activities = create_list(:activity, 4, credit: 20)

    activities.each do |activity|
      create(
        :programme_activity,
        programme_activity_grouping: i_belong_programme_activity_grouping,
        programme: i_belong,
        activity: activity
      )
    end

    activities
  end
  let!(:i_belong_programme_first_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 2, community: true, programme: i_belong) }
  let!(:i_belong_programme_second_community_activity_grouping) { create(:programme_activity_grouping, :with_activities, sort_key: 3, community: true, programme: i_belong) }

  describe ".generate_user_report" do
    it "Should clear out all UserReportEntries" do
      expect(UserReportEntry).to receive(:delete_all)

      ReportGeneration.generate_user_report
    end

    # Itterating over all of the users one by one would be devastating for performance.
    it "Should itterate over the users in batches" do
      expect(User).to receive(:in_batches)

      ReportGeneration.generate_user_report
    end

    it "Should create a record for each programme in PROGRAMMES for each user" do
      users = create_list(:user, 4)

      expect { ReportGeneration.generate_user_report }
        .to change { UserReportEntry.count }
        .by(users.size * ReportGeneration.programmes.size) # 12
    end

    context "When a users has completed the CPD compoent of one of the courses" do
      it "Should report completed_cpd_component true even if they're not enrolled" do
        user = create(:user)

        # Has completed primary requirements
        primary_activities.first(3).each do |activity|
          create(:achievement, user:, activity:).transition_to :complete
        end

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be true
        expect(primary_report_entry.user_enrolled).to be false
        expect(secondary_report_entry.completed_cpd_component).to be false
        expect(secondary_report_entry.user_enrolled).to be false
        expect(i_belong_report_entry.completed_cpd_component).to be false
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed the CPD component of all of the courses" do
      it "Should report completed_cpd_component true even if they're not entrolled" do
        user = create(:user)

        primary_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }
        secondary_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }
        i_belong_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be true
        expect(primary_report_entry.user_enrolled).to be false
        expect(secondary_report_entry.completed_cpd_component).to be true
        expect(secondary_report_entry.user_enrolled).to be false
        expect(i_belong_report_entry.completed_cpd_component).to be true
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed the first community component of one of the courses" do
      it "Should report completed_first_community_component true even if they're not enrolled" do
        user = create(:user)

        primary_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be false
        expect(primary_report_entry.completed_first_community_component).to be true
        expect(primary_report_entry.user_enrolled).to be false

        expect(secondary_report_entry.completed_cpd_component).to be false
        expect(secondary_report_entry.completed_first_community_component).to be false
        expect(secondary_report_entry.user_enrolled).to be false

        expect(i_belong_report_entry.completed_cpd_component).to be false
        expect(i_belong_report_entry.completed_first_community_component).to be false
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed the first community component of all of the courses" do
      it "Should report completed_first_community_component true even if they're not enrolled" do
        user = create(:user)

        primary_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        secondary_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        i_belong_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be false
        expect(primary_report_entry.completed_first_community_component).to be true
        expect(primary_report_entry.user_enrolled).to be false

        expect(secondary_report_entry.completed_cpd_component).to be false
        expect(secondary_report_entry.completed_first_community_component).to be true
        expect(secondary_report_entry.user_enrolled).to be false

        expect(i_belong_report_entry.completed_cpd_component).to be false
        expect(i_belong_report_entry.completed_first_community_component).to be true
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed the second community component of one of the courses" do
      it "Should report completed_second_community_component true even if they're not enrolled" do
        user = create(:user)

        primary_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be false
        expect(primary_report_entry.completed_first_community_component).to be false
        expect(primary_report_entry.completed_second_community_component).to be true
        expect(primary_report_entry.user_enrolled).to be false

        expect(secondary_report_entry.completed_cpd_component).to be false
        expect(secondary_report_entry.completed_first_community_component).to be false
        expect(secondary_report_entry.completed_second_community_component).to be false
        expect(secondary_report_entry.user_enrolled).to be false

        expect(i_belong_report_entry.completed_cpd_component).to be false
        expect(i_belong_report_entry.completed_first_community_component).to be false
        expect(i_belong_report_entry.completed_second_community_component).to be false
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed the second community component of all of the courses" do
      it "Should report completed_second_community_component true even if they're not enrolled" do
        user = create(:user)

        primary_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        secondary_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        i_belong_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be false
        expect(primary_report_entry.completed_first_community_component).to be false
        expect(primary_report_entry.completed_second_community_component).to be true
        expect(primary_report_entry.user_enrolled).to be false

        expect(secondary_report_entry.completed_cpd_component).to be false
        expect(secondary_report_entry.completed_first_community_component).to be false
        expect(secondary_report_entry.completed_second_community_component).to be true
        expect(secondary_report_entry.user_enrolled).to be false

        expect(i_belong_report_entry.completed_cpd_component).to be false
        expect(i_belong_report_entry.completed_first_community_component).to be false
        expect(i_belong_report_entry.completed_second_community_component).to be true
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "When a user has completed all components for all courses" do
      it "Should report completed_cpd_component, completed_first_community_component, completed_second_community_component true even if they're not enrolled" do
        user = create(:user)

        primary_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }
        secondary_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }
        i_belong_activities.first(3).each { |activity| create(:achievement, user:, activity:).transition_to :complete }

        primary_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        secondary_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        i_belong_programme_first_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        primary_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        secondary_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }
        i_belong_programme_second_community_activity_grouping.activities.each { create(:achievement, user:, activity: _1).transition_to :complete }

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")
        i_belong_report_entry = UserReportEntry.find_by(programme_slug: "i-belong")

        expect(primary_report_entry.completed_cpd_component).to be true
        expect(primary_report_entry.completed_first_community_component).to be true
        expect(primary_report_entry.completed_second_community_component).to be true
        expect(primary_report_entry.user_enrolled).to be false

        expect(secondary_report_entry.completed_cpd_component).to be true
        expect(secondary_report_entry.completed_first_community_component).to be true
        expect(secondary_report_entry.completed_second_community_component).to be true
        expect(secondary_report_entry.user_enrolled).to be false

        expect(i_belong_report_entry.completed_cpd_component).to be true
        expect(i_belong_report_entry.completed_first_community_component).to be true
        expect(i_belong_report_entry.completed_second_community_component).to be true
        expect(i_belong_report_entry.user_enrolled).to be false
      end
    end

    context "If the user is enrolled" do
      it "Should appear on in the report" do
        user = create(:user)

        create(:user_programme_enrolment, programme: primary_certificate, user:)

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")

        expect(primary_report_entry.user_enrolled).to be true
        expect(secondary_report_entry.user_enrolled).to be false
      end
    end

    context "If the user is enrollend and completed" do
      it "Should appear on in the report" do
        user = create(:user)

        upe = create(:user_programme_enrolment, programme: primary_certificate, user:)
        upe.transition_to :complete

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")

        expect(primary_report_entry.user_enrolled).to be true
        expect(primary_report_entry.completed_certificate).to be true
        expect(secondary_report_entry.user_enrolled).to be false
        expect(secondary_report_entry.completed_certificate).to be false
      end
    end

    context "If the user is enrollend and pending" do
      it "Should appear on in the report" do
        user = create(:user)

        upe = create(:user_programme_enrolment, programme: primary_certificate, user:)
        upe.transition_to :pending

        ReportGeneration.generate_user_report

        primary_report_entry = UserReportEntry.find_by(programme_slug: "primary-certificate")
        secondary_report_entry = UserReportEntry.find_by(programme_slug: "secondary-certificate")

        expect(primary_report_entry.user_enrolled).to be true
        expect(primary_report_entry.pending_certificate).to be true
        expect(secondary_report_entry.user_enrolled).to be false
        expect(secondary_report_entry.pending_certificate).to be false
      end
    end
  end
end
