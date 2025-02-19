require "rails_helper"

RSpec.describe StateMachines::UserProgrammeEnrolmentStateMachine do
  let(:programme) { create(:programme) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme:) }

  describe "initial state" do
    it "returns enrolled" do
      expect(described_class.initial_state).to eq "enrolled"
    end
  end

  describe "guards" do
    let(:user) { create(:user) }
    let(:primary_programme) { create(:primary_certificate, :with_activity_groupings) }
    let(:enrolment) { create(:user_programme_enrolment, user:, programme: primary_programme) }

    let(:setup_incomplete_enrolment) {
      enrolment
      pag = primary_programme.programme_activity_groupings.first
      act = pag.activities.first
      create(:completed_achievement, user:, activity: act)
    }

    let(:setup_completed_enrolment) {
      enrolment
      primary_programme.programme_activity_groupings.each do |pag|
        act = pag.activities.first
        create(:completed_achievement, user:, activity: act)
      end
    }

    it "can transition to complete when not flagged" do
      setup_completed_enrolment
      expect(user_programme_enrolment.transition_to(:complete)).to eq true
    end

    it "cannot transition to complete unless user has completed programme" do
      setup_incomplete_enrolment
      expect(enrolment.programme.user_meets_completion_requirement?(user)).to eq false
      expect(enrolment.transition_to(:complete)).to eq false
    end

    it "cannot transition to complete if flagged even when complete" do
      setup_completed_enrolment
      enrolment.update(flagged: true)
      expect(enrolment.transition_to(:complete)).to eq false
    end

    it "cannot transition to complete if flagged and not complete" do
      setup_incomplete_enrolment
      enrolment.update(flagged: true)
      expect(enrolment.transition_to(:complete)).to eq false
    end
  end

  describe "before_transition hooks" do
    it "sets certificate name when complete" do
      count = user_programme_enrolment.programme.programme_complete_counter.get_next_number
      user_programme_enrolment.transition_to(:complete)
      transition = user_programme_enrolment.last_transition
      expect(transition.metadata["certificate_number"]).to eq(count + 1)
    end
  end

  describe "after_transition hooks" do
    it "should ask the programme to update certificate complete data" do
      expect(programme).to receive(:set_user_programme_enrolment_complete_data).with(user_programme_enrolment)
      user_programme_enrolment.transition_to(:complete)
    end

    it "queues CompleteCertificateEmailJob job" do
      expect do
        user_programme_enrolment.transition_to(:complete)
      end.to have_enqueued_job(CompleteCertificateEmailJob)
    end

    it "queues a Pending email for I Belong certificate" do
      user = create(:user)
      user_programme_enrolment = create(:user_programme_enrolment, programme: create(:i_belong), user:)
      expect do
        user_programme_enrolment.transition_to(:pending)
      end.to have_enqueued_mail(IBelongMailer, :pending)
    end
  end
end
