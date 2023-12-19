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
    end
  end
end
