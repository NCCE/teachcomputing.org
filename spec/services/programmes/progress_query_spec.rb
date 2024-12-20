require "rails_helper"

RSpec.describe Programmes::ProgressQuery do
  let(:programme) { create(:programme) }
  let!(:course_group) {
    create(:programme_activity_groupings_credit_counted, programme:, metadata: {required_credit_count: 20})
  }
  let!(:community_group_1) { create(:programme_activity_grouping, programme:, community: true, required_for_completion: 2) }
  let!(:community_group_2) { create(:programme_activity_grouping, programme:, community: true) }
  let!(:course) {
    act = create(:activity, credit: 10)
    create(:programme_activity, activity: act, programme_activity_grouping: course_group, programme:)
    act
  }
  let!(:course_20c) {
    act = create(:activity, credit: 20)
    create(:programme_activity, activity: act, programme_activity_grouping: course_group, programme:)
    act
  }
  let!(:community_activity_1) {
    act = create(:activity)
    create(:programme_activity, activity: act, programme_activity_grouping: community_group_1, programme:)
    act
  }
  let!(:community_activity_2) {
    act = create(:activity)
    create(:programme_activity, activity: act, programme_activity_grouping: community_group_2, programme:)
    act
  }

  let!(:community_activity_1b) {
    act = create(:activity)
    create(:programme_activity, activity: act, programme_activity_grouping: community_group_1, programme:)
    act
  }

  let(:other_programme) { create(:programme) }
  let!(:other_course_group) { create(:programme_activity_groupings_credit_counted, programme: other_programme, metadata: {required_credit_count: 10}) }
  let!(:other_activity) {
    act = create(:activity)
    create(:programme_activity, activity: act, programme_activity_grouping: other_course_group, programme: other_programme)
    act
  }
  let!(:other_community_group_1) { create(:programme_activity_grouping, programme: other_programme, community: true) }
  let!(:other_community_activity_1) {
    act = create(:activity)
    create(:programme_activity, activity: act, programme_activity_grouping: other_community_group_1, programme: other_programme)
    act
  }

  let!(:course_activity_in_multiple_programmes) {
    act = create(:activity, credit: 20)
    create(:programme_activity, activity: act, programme_activity_grouping: other_course_group, programme: other_programme)
    create(:programme_activity, activity: act, programme_activity_grouping: course_group, programme: programme)
    act
  }

  def unenrolled_user
    user = create(:user)
    create(:user_programme_enrolment, user:, programme: other_programme)
    user
  end

  def enrolled_user
    user = create(:user)
    create(:user_programme_enrolment, user:, programme:)
    user
  end

  def active_achievement(user, activity)
    date = Faker::Time.between(from: DateTime.now.months_ago(4), to: DateTime.now.days_ago(1))
    create(:completed_achievement, activity:, user:, created_at: date, updated_at: date)
    user
  end

  def lapsing_achievement(user, activity)
    date = Faker::Time.between(from: DateTime.now.months_ago(8), to: DateTime.now.months_ago(4))
    create(:completed_achievement, activity:, user:, created_at: date, updated_at: date)
    user
  end

  def lapsed_achievement(user, activity)
    date = Faker::Time.between(from: DateTime.now.months_ago(12), to: DateTime.now.months_ago(8))
    create(:completed_achievement, activity:, user:, created_at: date, updated_at: date)
    user
  end

  it "enrolled_user should not have user_programme_enrolment" do
    # Test is to ensure that nothing has changed with auto enrolment that might impact this test suite
    expect(UserProgrammeEnrolment.where(user: unenrolled_user, programme:)).to be_empty
  end

  context "dates_by_state" do
    it "should return correct dates for active" do
      active_range = described_class.new(programme, :active, true).dates_by_state
      expect(active_range.first.to_date).to eq(DateTime.now.months_ago(4).to_date)
      expect(active_range.last.to_date).to eq(DateTime.now.to_date)
    end

    it "should return correct dates for lasping" do
      lapsing_range = described_class.new(programme, :lapsing, true).dates_by_state
      expect(lapsing_range.first.to_date).to eq(DateTime.now.months_ago(8).to_date)
      expect(lapsing_range.last.to_date).to eq(DateTime.now.months_ago(4).to_date)
    end
    it "should return correct dates for lasping" do
      lapsed_range = described_class.new(programme, :lapsed, true).dates_by_state
      expect(lapsed_range.first.to_date).to eq(DateTime.now.months_ago(1000).to_date)
      expect(lapsed_range.last.to_date).to eq(DateTime.now.months_ago(8).to_date)
    end

    it "should default to active range for non matching key" do
      active_range = described_class.new(programme, :unknown_key, true).dates_by_state
      expect(active_range.first.to_date).to eq(DateTime.now.months_ago(4).to_date)
      expect(active_range.last.to_date).to eq(DateTime.now.to_date)
    end
  end

  context "active user" do
    context "enrolled" do
      let!(:user_1) { active_achievement(enrolled_user, course) }
      let!(:user_2) {
        active_achievement(enrolled_user, community_activity_1)
      }
      let!(:user_3) {
        user = active_achievement(enrolled_user, community_activity_1)
        active_achievement(user, community_activity_1b)
      }
      let!(:user_4) { active_achievement(enrolled_user, course_20c) }
      let!(:user_with_activity_in_multiple) {
        user = active_achievement(enrolled_user, course_activity_in_multiple_programmes)
        create(:user_programme_enrolment, user:, programme: other_programme)
        user
      }
      let!(:user_with_activity_in_multiple_but_no_enrolment_to_other) {
        active_achievement(enrolled_user, course_activity_in_multiple_programmes)
      }
      let!(:user_lapsing) { lapsing_achievement(enrolled_user, community_activity_1) }
      let!(:user_lapsed) { lapsed_achievement(enrolled_user, community_activity_1) }
      let!(:no_match_user) { active_achievement(unenrolled_user, community_activity_1) }

      context "with no groups" do
        it "shoud return correct users" do
          result = described_class.new(programme, :active, true).call
          expect(result).to contain_exactly(user_1, user_2, user_3, user_4, user_with_activity_in_multiple, user_with_activity_in_multiple_but_no_enrolment_to_other)
          expect(result).not_to include no_match_user
          expect(result).not_to include user_lapsing
          expect(result).not_to include user_lapsed
        end

        it "shoud return correct users for other_programme" do
          result = described_class.new(other_programme, :active, true).call
          expect(result).to contain_exactly(user_with_activity_in_multiple)
        end
      end

      context "with single group" do
        it "using required_for_completion should return correct users" do
          result = described_class.new(programme, :active, true, [community_group_1]).call
          expect(result).to contain_exactly(user_3)
          expect(result).not_to include user_1
          expect(result).not_to include user_2
          expect(result).not_to include no_match_user
          expect(result).not_to include user_lapsing
          expect(result).not_to include user_lapsed
          expect(result).not_to include user_with_activity_in_multiple
        end

        context "with credits" do
          it "should not include users without enough credits" do
            result = described_class.new(programme, :active, true, [course_group]).call
            expect(result).not_to contain_exactly(user_1)
          end
          it "should include users with enough credits" do
            result = described_class.new(programme, :active, true, [course_group]).call
            expect(result).to contain_exactly(user_4, user_with_activity_in_multiple, user_with_activity_in_multiple_but_no_enrolment_to_other)
          end

          it "should include users with enough credits from other programme" do
            result = described_class.new(other_programme, :active, true, [other_course_group]).call
            expect(result).to contain_exactly(user_with_activity_in_multiple)
            expect(result).not_to include(user_with_activity_in_multiple_but_no_enrolment_to_other)
          end
        end
      end

      context "with mulitple groups" do
        let!(:user_both) {
          user = active_achievement(enrolled_user, community_activity_1)
          active_achievement(user, community_activity_1b)
          active_achievement(user, course_20c)
        }
        it "using required_for_completion should return correct users" do
          result = described_class.new(programme, :active, true, [community_group_1, course_group]).call
          expect(result).to contain_exactly(user_both)
        end
      end
    end

    context "unenrolled" do
      let!(:user_1) { active_achievement(enrolled_user, course) }
      let!(:not_enrolled_user) { active_achievement(unenrolled_user, community_activity_1) }
      let!(:user_with_activity_in_multiple_not_enrolled_programme) {
        active_achievement(unenrolled_user, course_activity_in_multiple_programmes)
      }
      let!(:user_with_activity_in_multiple_and_enrolled_programme) {
        user = active_achievement(enrolled_user, course_activity_in_multiple_programmes)
        create(:user_programme_enrolment, user:, programme: other_programme)
        user
      }

      it "with no groups" do
        result = described_class.new(programme, :active, false).call
        expect(result).to contain_exactly(not_enrolled_user, user_with_activity_in_multiple_not_enrolled_programme)
        expect(result).not_to include user_1
        expect(result).not_to include user_with_activity_in_multiple_and_enrolled_programme
      end
    end
  end

  context "lapsing user" do
    context "enrolled" do
      let!(:user_1) { lapsing_achievement(enrolled_user, course) }
      let!(:user_2) { lapsing_achievement(enrolled_user, community_activity_1) }
      let!(:user_active) { active_achievement(enrolled_user, community_activity_1) }
      let!(:user_lapsed) { lapsed_achievement(enrolled_user, community_activity_1) }
      let!(:no_match_user) { lapsing_achievement(unenrolled_user, community_activity_1) }

      it "with no groups" do
        result = described_class.new(programme, :lapsing, true).call
        expect(result).to contain_exactly(user_1, user_2)
        expect(result).not_to include no_match_user
        expect(result).not_to include user_active
        expect(result).not_to include user_lapsed
      end
    end

    context "unenrolled" do
      let!(:user_1) { lapsing_achievement(enrolled_user, course) }
      let!(:not_enrolled_user) { lapsing_achievement(unenrolled_user, community_activity_1) }

      it "with no groups" do
        result = described_class.new(programme, :lapsing, false).call
        expect(result).to contain_exactly(not_enrolled_user)
        expect(result).not_to include user_1
      end
    end
  end

  context "lapsed user" do
    context "enrolled" do
      let!(:user_1) { lapsed_achievement(enrolled_user, course) }
      let!(:user_2) { lapsed_achievement(enrolled_user, community_activity_1) }
      let!(:user_active) { active_achievement(enrolled_user, community_activity_1) }
      let!(:user_lapsing) { lapsing_achievement(enrolled_user, community_activity_1) }
      let!(:no_match_user) { active_achievement(unenrolled_user, community_activity_1) }

      it "with no groups" do
        result = described_class.new(programme, :lapsed, true).call
        expect(result).to contain_exactly(user_1, user_2)
        expect(result).not_to include no_match_user
        expect(result).not_to include user_lapsing
        expect(result).not_to include user_active
      end
    end

    context "unenrolled" do
      let!(:user_1) { lapsed_achievement(enrolled_user, course) }
      let!(:not_enrolled_user) { lapsed_achievement(unenrolled_user, community_activity_1) }

      it "with no groups" do
        result = described_class.new(programme, :lapsed, false).call
        expect(result).to contain_exactly(not_enrolled_user)
        expect(result).not_to include user_1
      end
    end
  end
end
