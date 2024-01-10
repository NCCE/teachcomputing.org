require "rails_helper"

RSpec.describe StateMachines::AchievementStateMachine do
  let(:achievement) { create(:achievement) }
  let(:online_achievement) { create(:achievement, activity: create(:activity, category: Activity::FACE_TO_FACE_CATEGORY)) }
  let(:face_to_face_achievement) { create(:achievement, activity: create(:activity, category: Activity::ONLINE_CATEGORY)) }
  let(:action_achievement) { create(:achievement, activity: create(:activity, category: Activity::ACTION_CATEGORY)) }
  let(:assessment_achievement) { create(:achievement, activity: create(:activity, category: Activity::ASSESSMENT_CATEGORY)) }
  let(:community_achievement) { create(:achievement, activity: create(:activity, category: Activity::COMMUNITY_CATEGORY)) }
  let(:diagnostic_achievement) { create(:achievement, activity: create(:activity, category: Activity::DIAGNOSTIC_CATEGORY)) }

  describe "guards" do
    it "can transition from state enrolled to allowed states" do
      %i[in_progress complete dropped].each do |allowed_state|
        expect { create(:achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it "can transition from state in_progress to allowed states" do
      %i[complete dropped].each do |allowed_state|
        expect { create(:in_progress_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it "can transition from state dropped to other states" do
      %i[enrolled in_progress complete].each do |allowed_state|
        expect { create(:dropped_achievement).state_machine.transition_to!(allowed_state) }
          .not_to raise_error
      end
    end

    it "cannot transition from state in_progress to other states" do
      [:enrolled].each do |disallowed_state|
        expect { create(:in_progress_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end

    it "cannot transition from state complete to other states" do
      %i[enrolled in_progress dropped].each do |disallowed_state|
        expect { create(:completed_achievement).state_machine.transition_to!(disallowed_state) }
          .to raise_error(Statesman::TransitionFailedError)
      end
    end
  end

  describe "after_transition hooks" do
    it "queues CompleteAchievementEmailJob when state complete for the expected categories" do
      [online_achievement, face_to_face_achievement].each do |allowed_achievement|
        expect { allowed_achievement.transition_to(:complete) }.to have_enqueued_job(CompleteAchievementEmailJob)
      end
    end

    it "doesn't queue CompleteAchievementEmailJob when state complete for the expected categories" do
      [action_achievement, assessment_achievement, community_achievement, diagnostic_achievement].each do |disallowed_achievement|
        expect { disallowed_achievement.transition_to(:complete) }.not_to have_enqueued_job(CompleteAchievementEmailJob)
      end
    end

    it "calls issue_badge" do
      expect { face_to_face_achievement.transition_to(:complete) }.to have_enqueued_job(IssueBadgeJob)
    end
  end
end
