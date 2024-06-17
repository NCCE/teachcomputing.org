require "rails_helper"

RSpec.describe UserProgrammeEnrolmentTransition, type: :model do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user: user, programme: cs_accelerator) }
  let!(:transition1) { create(:user_programme_enrolment_transition, user_programme_enrolment: cs_accelerator_enrolment, sort_key: 1, most_recent: false, to_state: "enrolled") }
  let!(:transition2) { create(:user_programme_enrolment_transition, user_programme_enrolment: cs_accelerator_enrolment, sort_key: 2, most_recent: true, to_state: "complete") }

  describe "associations" do
    it { is_expected.to belong_to(:user_programme_enrolment) }
  end

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:to_state).in_array(StateMachines::UserProgrammeEnrolmentStateMachine.states) }
  end

  describe "callbacks" do
    context "after_destroy" do
      it "updates the most recent transition if the destroyed transition was the most recent" do
        transition2.destroy

        transition1.reload
        expect(transition1.most_recent).to be true
      end

      it "does not update the most recent transition if the destroyed transition was not the most recent" do
        transition1.destroy

        transition2.reload
        expect(transition2.most_recent).to be true
      end
    end
  end
end
