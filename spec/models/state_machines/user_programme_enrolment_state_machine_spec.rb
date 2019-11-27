require 'rails_helper'

RSpec.describe StateMachines::UserProgrammeEnrolmentStateMachine do
  let(:user_programme_enrolment) { create(:user_programme_enrolment) }


  describe 'initial state' do
    it 'returns enrolled' do
      expect(StateMachines::UserProgrammeEnrolmentStateMachine.initial_state).to eq 'enrolled' 
    end
  end
end