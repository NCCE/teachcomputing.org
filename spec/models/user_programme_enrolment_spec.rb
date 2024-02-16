require "rails_helper"

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user: user, programme: cs_accelerator) }
  let(:assessment) { create(:assessment, programme: cs_accelerator) }
  let(:successful_assessment_attempt) { create(:completed_assessment_attempt, user:, assessment:) }
  let(:questionnaire_response) { create(:cs_accelerator_enrolment_score_1) }
  let!(:new_to_computing_pathway) { create(:new_to_computing) }

  describe "associations" do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:user_programme_enrolment_transitions) }
  end

  describe "validations" do
    it "ensures user can only be enrolled on a programme once" do
      create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      enrolment = build(:user_programme_enrolment, user: user, programme: cs_accelerator)
      expect(enrolment.valid?).to eq(false)
      expect(enrolment.errors.messages[:user]).to eq(["has already been taken"])
    end
  end

  describe "#completed_at?" do
    it "returns nil" do
      expect(cs_accelerator_enrolment.completed_at?).to eq nil
    end

    context "when complete" do
      it "returns the date of transition" do
        successful_assessment_attempt
        cs_accelerator_enrolment.transition_to(:complete)
        expect(cs_accelerator_enrolment.created_at?).not_to eq nil
      end
    end
  end

  describe "#set_pathway" do
    it "sets the pathway id" do
      cs_accelerator
      upe = create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      upe.assign_recommended_pathway(questionnaire_response)
      expect(upe.pathway_id).to eq(new_to_computing_pathway.id)
    end
  end

  describe "delegates" do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
    it { is_expected.to delegate_method(:in_state?).to(:state_machine).as(:in_state?) }
  end

  describe "after transitioning to complete" do
    subject { create(:user_programme_enrolment) }

    it "should call Programme#set_user_programme_enrolment_complete_data" do
      expect(subject.programme).to receive(:set_user_programme_enrolment_complete_data).with(subject)

      subject.transition_to :complete
    end
  end
end
