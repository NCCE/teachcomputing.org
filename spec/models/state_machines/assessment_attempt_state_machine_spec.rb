require "rails_helper"

RSpec.describe StateMachines::AssessmentAttemptStateMachine do
  let(:assessment_attempt) { create(:assessment_attempt) }

  describe "guards" do
    it "can transition from state commenced to state passed" do
      expect { assessment_attempt.state_machine.transition_to!(:passed) }
        .not_to raise_error
    end

    it "can transition from state commenced to state failed" do
      expect { assessment_attempt.state_machine.transition_to!(:failed) }
        .not_to raise_error
    end

    it "cannot transition from state passed to state failed" do
      assessment_attempt.state_machine.transition_to!(:passed)
      expect { assessment_attempt.state_machine.transition_to!(:failed) }
        .to raise_error(Statesman::TransitionFailedError)
    end

    it "cannot transition from state passed to state commenced" do
      assessment_attempt.state_machine.transition_to!(:passed)
      expect { assessment_attempt.state_machine.transition_to!(:commenced) }
        .to raise_error(Statesman::TransitionFailedError)
    end
  end
end
