require "rails_helper"

RSpec.describe IBelongUsersAffected do
  let(:programme) { create(:i_belong) }
  let(:activity_understanding) { create(:activity) }
  let(:programme_activity_grouping_understanding) { create(:programme_activity_grouping, programme:, required_for_completion: 1, sort_key: 2) }
  let(:programme_activity_understanding) { create(:programme_activity, programme:, activity: activity_understanding, programme_activity_grouping: programme_activity_grouping_understanding) }
  let(:activity_resources1) { create(:activity, slug: 'download-and-use-the-i-belong-handbook') }
  let(:activity_resources2) { create(:activity, slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources') }
  let(:activity_resources3) { create(:activity) }
  let(:programme_activity_grouping_resources) { create(:programme_activity_grouping, programme:, required_for_completion: 3, sort_key: 3) }
  let(:programme_activity_resources1) { create(:programme_activity, programme:, activity: activity_resources1, programme_activity_grouping: programme_activity_grouping_resources) }
  let(:programme_activity_resources2) { create(:programme_activity, programme:, activity: activity_resources2, programme_activity_grouping: programme_activity_grouping_resources) }
  let(:programme_activity_resources3) { create(:programme_activity, programme:, activity: activity_resources3, programme_activity_grouping: programme_activity_grouping_resources) }
  let(:activity_engagement) { create(:activity) }
  let(:programme_activity_grouping_engagement) { create(:programme_activity_grouping, programme:, required_for_completion: 1, sort_key: 4) }
  let(:programme_activity_engagement) { create(:programme_activity, programme:, activity: activity_engagement, programme_activity_grouping: programme_activity_grouping_engagement) }

  before do
    programme_activity_understanding
    programme_activity_resources1
    programme_activity_resources2
    programme_activity_resources3
    programme_activity_engagement
  end

  describe ".completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources" do
    context "user meets criteria" do
      describe "all criteria are satisfied" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:completed_achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the correct emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources).to match_array(['test@example.com'])
        end
      end
    end
    
    context "user does not meet criteria" do
      describe "user has NOT completed a CPD activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:completed_achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources).to match_array([])
        end
      end

      describe "user has NOT completed the download activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:completed_achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources).to match_array([])
        end
      end

      describe "user has completed the tcc activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:completed_achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:completed_achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end


        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources).to match_array([])
        end
      end

      describe "user has NOT completed a third grouping activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_completed_NO_tcc_resources).to match_array([])
        end
      end
    end 
  end

  describe "completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources" do
    context "user meets criteria" do
      describe "all criteria are satisfied" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:completed_achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the correct emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources).to match_array(['test@example.com'])
        end
      end
    end
    
    context "user does not meet criteria" do
      describe "user has NOT completed a CPD activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:completed_achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources).to match_array([])
        end
      end

      describe "user has NOT completed the download activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:completed_achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources).to match_array([])
        end
      end

      describe "user has NOT completed the tcc activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources).to match_array([])
        end
      end

      describe "user has completed a third grouping activity" do
        let(:user) { create(:user, email: 'test@example.com') }
        let(:user_upe) { create(:user_programme_enrolment, user: user, programme:, created_at: 2.months.ago) }
  
        before do
          user_upe

          cpd_activity = programme.programme_activity_groupings.first.activities.first
          cpd_achievement = create(:completed_achievement, activity: cpd_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          download_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'download-and-use-the-i-belong-handbook')
          download_achievement = create(:completed_achievement, activity: download_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
          
          tcc_activity = programme.programme_activity_groupings.second.activities.find_by(slug: 'implement-selected-key-stage-3-teach-computing-curriculum-resources')
          tcc_achievement = create(:completed_achievement, activity: tcc_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)

          third_grouping_activity = programme.programme_activity_groupings.third.activities.first
          third_grouping_achievement = create(:completed_achievement, activity: third_grouping_activity, user: user, created_at: 2.months.ago, updated_at: 2.months.ago)
        end

        it "lists the no emails" do
          expect(IBelongUsersAffected.completed_cpds_downloaded_resources_activity_NOT_completed_tcc_resources).to match_array([])
        end
      end
    end
  end
end
