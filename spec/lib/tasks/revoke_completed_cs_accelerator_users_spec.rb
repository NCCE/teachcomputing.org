# frozen_string_literal: true

require 'rails_helper'
require 'csv'
require 'rake'
require 'securerandom'

RSpec.describe 'rake csa:revoke', type: :task do
  let(:csv_path) { 'csa_revoke.csv' }
  let(:user) { create(:user, stem_achiever_contact_no: SecureRandom.uuid, email: ENV.fetch('DEFAULT_ADMIN_EMAIL')) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }
  let(:eligible_csa_achievement) { create(:achievement, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:incorrect_stem_achiever_contact_no) { SecureRandom.uuid.upcase }
  let(:incorrect_email) { 'definitely@not.this' }

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

    it 'unsets CSA enrolment' do
      expect(user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id).in_state?(:complete)).to be true
      task.execute
      expect(user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id).in_state?(:complete)).to be false
      expect(user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id).in_state?(:enrolled)).to be true
    end
  end

  context 'with an incorrect header' do
    before do
      CSV.open(csv_path, 'w', write_headers: true,
                              headers: %w[name STEMID email]) do |writer|
        writer << ["#{user.first_name} #{user.last_name}", user.stem_achiever_contact_no.upcase, user.email]
      end
    end

    it 'logs a warning' do
      allow(Rails.logger).to receive(:warn).at_least(:once)
      task.execute
      expect(Rails.logger).to have_received(:warn)
    end
  end

  context 'with a mismatched stem_achiever_contact_no' do
    before do
      CSV.open(csv_path, 'w', write_headers: true,
                              headers: ['name', 'STEM ID', 'email']) do |writer|
        writer << ["#{user.first_name} #{user.last_name}", incorrect_stem_achiever_contact_no, user.email]
      end
    end

    it 'reports a problem' do
      allow($stdout).to receive(:puts).at_least(:once)
      task.execute
      expect($stdout).to have_received(:puts).with("user with stem_achiever_contact_no #{incorrect_stem_achiever_contact_no} not found")
    end
  end

  context 'with an incorrect email' do
    before do
      CSV.open(csv_path, 'w', write_headers: true,
                              headers: ['name', 'STEM ID', 'email']) do |writer|
        writer << ["#{user.first_name} #{user.last_name}", user.stem_achiever_contact_no.upcase, incorrect_email]
      end
    end

    it 'reports a problem' do
      allow($stdout).to receive(:puts).at_least(:once)
      task.execute
      expect($stdout).to have_received(:puts).with("#{user.stem_achiever_contact_no.upcase} has the email #{user.email} in the database not #{incorrect_email} as in the CSV")
    end
  end
end
