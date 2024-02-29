require "rails_helper"

RSpec.describe ScheduleCertificateCompletionJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  describe "#perform" do
    it "should transition UPE to complete after pending delay observed" do
      user_programme_enrolment.transition_to(:pending)
      travel_to(programme.pending_delay.from_now - 1.days) do
        described_class.perform_now(user_programme_enrolment)
        expect(user_programme_enrolment.in_state?(:complete)).to be false
      end
      travel_to(programme.pending_delay.from_now + 1.second) do
        described_class.perform_now(user_programme_enrolment)
        expect(user_programme_enrolment.in_state?(:complete)).to be true
      end
    end

    it "should not transition unless latest transition is older than pending delay" do
      user_programme_enrolment.transition_to(:pending)
      travel_to(DateTime.now + 2.days) do
        user_programme_enrolment.transition_to(:enrolled)
      end
      travel_to(DateTime.now + 3.days) do
        user_programme_enrolment.transition_to(:pending)
      end
      travel_to(programme.pending_delay.from_now) do
        described_class.perform_now(user_programme_enrolment)
        expect(user_programme_enrolment.in_state?(:complete)).to be false
      end
      travel_to(programme.pending_delay.from_now + 3.days) do
        described_class.perform_now(user_programme_enrolment)
        expect(user_programme_enrolment.in_state?(:complete)).to be true
      end
    end

    it "will only transition pending enrolments" do
      user_programme_enrolment.transition_to(:enrolled)

      described_class.perform_now(user_programme_enrolment)
      expect(user_programme_enrolment.in_state?(:complete)).to be false

      travel_to(programme.pending_delay.from_now) do
        described_class.perform_now(user_programme_enrolment)
        expect(user_programme_enrolment.in_state?(:complete)).to be false
      end
    end
  end
end
