require 'rails_helper'

RSpec.describe InactivityQueries do
  describe '.no_activities_completed' do
    it 'returns all users who have completed no activities for the programme' do
      cs_accelerator = create(:cs_accelerator)
      primary_certificate = create(:primary_certificate)
      activity1 = create(:activity)
      create(:programme_activity, activity: activity1, programme: cs_accelerator)
      activity2 = create(:activity)
      create(:programme_activity, activity: activity2, programme: primary_certificate)

      # Should not have one sent
      some_completed = create(:user, first_name: 'A')
      create(:user_programme_enrolment, user: some_completed, programme: cs_accelerator, created_at: 2.months.ago)
      create(:achievement, activity: activity1, user: some_completed, updated_at: 2.months.ago, created_at: 2.months.ago)

      # Should not have one sent
      upe_too_young_completed = create(:user, first_name: 'B')
      create(:user_programme_enrolment, user: upe_too_young_completed, programme: cs_accelerator, created_at: 1.day.ago)

      # Should not have one sent
      already_sent_email = create(:user, first_name: 'C')
      create(:user_programme_enrolment, user: already_sent_email, programme: cs_accelerator, created_at: 2.months.ago)
      create(:sent_email, mailer_type: InactivityQueries.no_activities_completed_type(cs_accelerator.slug), user: already_sent_email)

      # Should not have one sent
      some_too_young_completed = create(:user, first_name: 'D')
      create(:user_programme_enrolment, user: some_too_young_completed, programme: cs_accelerator, created_at: 2.months.ago)
      create(:achievement, activity: activity1, user: some_too_young_completed, updated_at: 1.day.ago, created_at: 2.months.ago)

      # Should not have one sent
      others_completed = create(:user, first_name: 'E')
      create(:user_programme_enrolment, user: others_completed, programme: primary_certificate, created_at: 2.months.ago)
      create(:achievement, activity: activity2, user: others_completed, updated_at: 2.months.ago, created_at: 2.months.ago)

      # Should not have one sent
      others_still_enrolled_completed = create(:user, first_name: 'F')
      create(:user_programme_enrolment, user: others_still_enrolled_completed, programme: primary_certificate, created_at: 2.months.ago)
      create(:user_programme_enrolment, user: others_still_enrolled_completed, programme: cs_accelerator, created_at: 2.months.ago)
      create(:achievement, activity: activity2, user: others_still_enrolled_completed, updated_at: 2.months.ago, created_at: 2.months.ago)

      # Should have one sent
      none_completed = create(:user, first_name: 'G')
      create(:user_programme_enrolment, user: none_completed, programme: cs_accelerator, created_at: 2.months.ago)

      expect(InactivityQueries.no_activities_completed(cs_accelerator)).to match_array [none_completed, others_still_enrolled_completed]
    end
  end

  describe '.i_belong_only_one_section_completed' do
    it 'should only return users whose achievements are all older than a month and have completed one programme objective' do
      # Setup I belong
      i_belong = create(:i_belong)
      pag1 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 1, sort_key: 2)
      activity1_1 = create(:activity)
      create(:programme_activity, activity: activity1_1, programme_activity_grouping: pag1)
      pag2 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 3, sort_key: 3)
      activity2_1 = create(:activity)
      create(:programme_activity, activity: activity2_1, programme_activity_grouping: pag2)
      activity2_2 = create(:activity)
      create(:programme_activity, activity: activity2_2, programme_activity_grouping: pag2)
      activity2_3 = create(:activity)
      create(:programme_activity, activity: activity2_3, programme_activity_grouping: pag2)
      pag3 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 1, sort_key: 4)
      activity3_1 = create(:activity)
      create(:programme_activity, activity: activity3_1, programme_activity_grouping: pag3)

      # User who has completed pag1
      pag1_user = create(:user)
      create(:user_programme_enrolment, user: pag1_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 2.months.ago, user: pag1_user)

      # User who has completed pag1 who is already warned
      pag1_already_warned_user = create(:user)
      create(:user_programme_enrolment, user: pag1_already_warned_user, programme: i_belong, created_at: 1.day.ago)
      create(:sent_email, mailer_type: InactivityQueries.i_belong_only_one_section_completed_type, user: pag1_already_warned_user)
      create(:completed_achievement, activity: activity1_1, updated_at: 2.months.ago, user: pag1_already_warned_user)

      # User who has completed pag1 recently
      pag1_new_user = create(:user)
      create(:user_programme_enrolment, user: pag1_new_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 1.day.ago, user: pag1_new_user)

      # User who has completed pag 1 and another pag
      pag1_and_another_user = create(:user)
      create(:user_programme_enrolment, user: pag1_and_another_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 2.months.ago, user: pag1_and_another_user)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag1_and_another_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 2.months.ago, user: pag1_and_another_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 2.months.ago, user: pag1_and_another_user)

      # User who has completed pag2
      pag2_user = create(:user)
      create(:user_programme_enrolment, user: pag2_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 2.months.ago, user: pag2_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 2.months.ago, user: pag2_user)

      # User who has completed pag2 recently
      pag2_new_user = create(:user)
      create(:user_programme_enrolment, user: pag2_new_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 1.day.ago, user: pag2_new_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 1.day.ago, user: pag2_new_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 1.day.ago, user: pag2_new_user)

      # User who has completed pag1 who is already warned
      pag2_already_warned_user = create(:user)
      create(:user_programme_enrolment, user: pag2_already_warned_user, programme: i_belong, created_at: 1.day.ago)
      create(:sent_email, mailer_type: InactivityQueries.i_belong_only_one_section_completed_type, user: pag2_already_warned_user)
      create(:completed_achievement, activity: activity2_1, updated_at: 1.day.ago, user: pag2_already_warned_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 1.day.ago, user: pag2_already_warned_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 1.day.ago, user: pag2_already_warned_user)

      # User who has completed pag3
      pag3_user = create(:user)
      create(:user_programme_enrolment, user: pag3_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity3_1, updated_at: 2.months.ago, user: pag3_user)

      # User who has completed pag1 who is already warned
      pag3_already_warned_user = create(:user)
      create(:user_programme_enrolment, user: pag3_already_warned_user, programme: i_belong, created_at: 1.day.ago)
      create(:sent_email, mailer_type: InactivityQueries.i_belong_only_one_section_completed_type, user: pag3_already_warned_user)
      create(:completed_achievement, activity: activity3_1, updated_at: 2.months.ago, user: pag3_already_warned_user)

      # User who has completed pag3 recently
      pag3_new_user = create(:user)
      create(:user_programme_enrolment, user: pag3_new_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity3_1, updated_at: 1.day.ago, user: pag3_new_user)

      expect(InactivityQueries.i_belong_only_one_section_completed).to match_array [pag1_user, pag2_user, pag3_user]
    end
  end

  describe '.i_belong_completed_x_appart_from' do
    it 'should return users who have completed only two of the required activities in the second PAG' do
      # Setup I belong
      i_belong = create(:i_belong)
      pag1 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 1, sort_key: 2)
      activity1_1 = create(:activity)
      create(:programme_activity, activity: activity1_1, programme_activity_grouping: pag1)
      pag2 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 3, sort_key: 3)
      activity2_1 = create(:activity)
      create(:programme_activity, activity: activity2_1, programme_activity_grouping: pag2)
      activity2_2 = create(:activity)
      create(:programme_activity, activity: activity2_2, programme_activity_grouping: pag2)
      activity2_3 = create(:activity)
      create(:programme_activity, activity: activity2_3, programme_activity_grouping: pag2)
      pag3 = create(:programme_activity_grouping, programme: i_belong, required_for_completion: 1, sort_key: 4)
      activity3_1 = create(:activity)
      create(:programme_activity, activity: activity3_1, programme_activity_grouping: pag3)

      # User who has completed two activities and are both old
      pag2_user = create(:user)
      create(:user_programme_enrolment, user: pag2_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 2.months.ago, user: pag2_user)

      # User who has drafted two different
      pag2_draft_user = create(:user)
      create(:user_programme_enrolment, user: pag2_draft_user, programme: i_belong, created_at: 1.day.ago)
      create(:drafted_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_draft_user)
      create(:drafted_achievement, activity: activity2_3, updated_at: 2.months.ago, user: pag2_draft_user)

      # User who has completed one activity
      pag2_one_user = create(:user)
      create(:user_programme_enrolment, user: pag2_one_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_one_user)

      # User who has completed one pag2 activity and one pag3 activity
      pag2_mixed_user = create(:user)
      create(:user_programme_enrolment, user: pag2_mixed_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_mixed_user)
      create(:completed_achievement, activity: activity3_1, updated_at: 2.months.ago, user: pag2_mixed_user)

      # User who has completed all of pag2
      pag2_all_complete_user = create(:user)
      create(:user_programme_enrolment, user: pag2_all_complete_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_all_complete_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 2.months.ago, user: pag2_all_complete_user)
      create(:completed_achievement, activity: activity2_3, updated_at: 2.months.ago, user: pag2_all_complete_user)

      # User who has completed some of pag2 and pag3
      pag2_some_complete_user = create(:user)
      create(:user_programme_enrolment, user: pag2_some_complete_user, programme: i_belong, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 2.months.ago, user: pag2_some_complete_user)
      create(:completed_achievement, activity: activity2_2, updated_at: 2.months.ago, user: pag2_some_complete_user)
      create(:completed_achievement, activity: activity3_1, updated_at: 2.months.ago, user: pag2_some_complete_user)

      expect(InactivityQueries.i_belong_completed_x_appart_from).to match_array [pag2_user, pag2_draft_user, pag2_some_complete_user]
    end
  end

  describe ".completed_cpds_but_no_community_activities" do
    it "should return users who have completed all the cpds but no community activities" do
      # Build primary certificate
      primary_certificate = create(:primary_certificate)
      pag1 = create(:programme_activity_grouping, programme: primary_certificate, required_for_completion: 1)
      activity1_1 = create(:activity)
      create(:programme_activity, activity: activity1_1, programme: primary_certificate, programme_activity_grouping: pag1)
      activity1_2 = create(:activity)
      create(:programme_activity, activity: activity1_2, programme: primary_certificate, programme_activity_grouping: pag1)
      pag2 = create(:programme_activity_grouping, programme: primary_certificate, required_for_completion: 1)
      activity2_1 = create(:activity, :community)
      create(:programme_activity, activity: activity2_1, programme: primary_certificate, programme_activity_grouping: pag2)
      activity2_2 = create(:activity, :community)
      create(:programme_activity, activity: activity2_2, programme: primary_certificate, programme_activity_grouping: pag2)

      # User who has completed only CPDs
      user = create(:user)
      create(:user_programme_enrolment, user: user, programme: primary_certificate, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 4.months.ago, user: user)

      # User who has completed multiple CPDs
      user_multiple = create(:user)
      create(:user_programme_enrolment, user: user_multiple, programme: primary_certificate, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 4.months.ago, user: user_multiple)
      create(:completed_achievement, activity: activity1_2, updated_at: 4.months.ago, user: user_multiple)

      # User who has completed new CPDs
      user_new = create(:user)
      create(:user_programme_enrolment, user: user_new, programme: primary_certificate, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 4.months.ago, user: user_new)
      create(:completed_achievement, activity: activity1_2, updated_at: 1.day.ago, user: user_new)

      # User who has completed new a community activity
      user_community = create(:user)
      create(:user_programme_enrolment, user: user_community, programme: primary_certificate, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity1_1, updated_at: 4.months.ago, user: user_community)
      create(:completed_achievement, activity: activity2_2, updated_at: 4.months.ago, user: user_community)

      # User who has completed only community activities
      user_community_only = create(:user)
      create(:user_programme_enrolment, user: user_community_only, programme: primary_certificate, created_at: 1.day.ago)
      create(:completed_achievement, activity: activity2_1, updated_at: 4.months.ago, user: user_community_only)
      create(:completed_achievement, activity: activity2_2, updated_at: 4.months.ago, user: user_community_only)

      expect(InactivityQueries.completed_cpds_but_no_community_activities(primary_certificate)).to match_array [user, user_multiple]
    end
  end
end
