# frozen_string_literal: true

require 'rails_helper'
require 'csv'
require 'rake'
require 'securerandom'

RSpec.describe 'rake csa:revoke', type: :task do
  let(:csv_path) { 'csa_revoke.csv' }
  let(:user) { create(:user, stem_achiever_contact_no: SecureRandom.uuid) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }
  let(:eligible_csa_achievement) { create(:achievement, user_id: user.id, programme_id: cs_accelerator.id) }

  before do
    create(:assessment_attempt, user:)
    cs_enrolment.transition_to(:complete)
    eligible_csa_achievement.transition_to(:complete)
  end

  after do
    File.delete(csv_path)
  end

  context 'with a correct CSV' do
    before do
      CSV.open(csv_path, 'w', write_headers: true,
                              headers: ['name', 'STEM ID', 'email']) do |writer|
        writer << ["#{user.first_name} #{user.last_name}", user.stem_achiever_contact_no.upcase, user.email]
      end
    end

    it 'removes assesment attempt' do
      expect(user.assessment_attempts).not_to be_empty
      task.execute
      expect(user.assessment_attempts).to be_empty
    end

    it 'unsets enrolment' do
      expect(cs_enrolment.in_state?(:complete)).to be true
      task.execute
      expect(cs_enrolment.in_state?(:complete)).to be false
      expect(cs_enrolment.in_state?(:enrolled)).to be true
    end

    it 'unsets acheivement' do
      expect(eligible_csa_achievement.in_state?(:complete)).to be true
      task.execute
      expect(eligible_csa_achievement.in_state?(:complete)).to be false
      expect(eligible_csa_achievement.in_state?(:enrolled)).to be true
    end
  end

  context 'with a mismatched stem_achiever_contact_no' do
    before do
      CSV.open(csv_path, 'w', write_headers: true,
                              headers: ['name', 'STEM ID', 'email']) do |writer|
        writer << ["#{user.first_name} #{user.last_name}", SecureRandom.uuid.upcase, user.email]
      end
    end

    it 'removes logs a warning' do
      allow(Rails.logger).to receive(:warn).at_least(:once)
      task.execute
      #expect(Rails.logger).to have_received(:warn)
      expect(User.find(user.id).assessment_attempts).to be_empty
    end
  end
end
