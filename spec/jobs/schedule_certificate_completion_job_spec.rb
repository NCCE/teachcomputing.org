require "rails_helper"

RSpec.describe ScheduleCertificateCompletionJob, type: :job do
  let(:school) { "Bath School" }
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let(:counter) { 21 }
  let(:programme_complete_counter) { create(:programme_complete_counter, programme:, counter: 21) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  describe "#perform" do
    before do
      programme_complete_counter
    end

    it "should increment programme counter" do
      expect(programme_complete_counter).to receive(:get_next_number)
      described_class.perform_now(user_programme_enrolment)
    end

    it "should transition UPE to complete" do
      described_class.perform_now(user_programme_enrolment)

      expect(user_programme_enrolment.in_state?(:complete)).to be true
    end

    it "should set transition certificate number metadata PCC value" do
      described_class.perform_now(user_programme_enrolment)

      expect(user_programme_enrolment.last_transition.metadata["certificate_number"]).to eq programme_complete_counter.counter
    end

    it "should ask the programme to update certificate complete data" do
      expect(programme).to receive(:set_user_programme_enrolment_complete_data).with(user_programme_enrolment)

      described_class.perform_now(user_programme_enrolment)
    end
  end
end
