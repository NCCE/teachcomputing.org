require 'rails_helper'

RSpec.describe CSADash do
  let!(:csa) { create(:cs_accelerator) }
  let(:dash) { described_class.new(user: user) }
  let(:user) { create(:user) }

  describe '#user_programme_pathway' do
    it 'returns nil if user not on pathway' do
      expect(dash.user_programme_pathway).to eq(nil)
    end

    it 'returns pathway user is on' do
      pathway = create(:pathway, programme: csa)
      create(:user_programme_enrolment, user: user, programme: csa, pathway: pathway)

      expect(dash.user_programme_pathway).to eq(pathway)
    end
  end

  describe '#compulsory_achievement' do
  end
end
