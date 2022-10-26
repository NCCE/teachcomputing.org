# frozen_string_literal: true

require 'rails_helper'
require 'csv'
require 'rake'
require 'securerandom'

RSpec.describe 'rake csa:revoke', type: :task do
  let(:csv_path) { 'csa_revoke.csv' }
  let(:user) { create(:user, stem_achiever_contact_no: SecureRandom.uuid) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:cs_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }
  # let(:secondary_enrolment) do
  #   create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id)
  # end
  # let(:additional_csa_activity) { create(:activity, slug: 'complete-a-cs-accelerator-course') }
  # let(:additional_csa_achievement_for_secondary) do
  #   create(:achievement, activity_id: additional_csa_activity.id, user_id: user.id,
  #                        programme_id: secondary_certificate.id)
  # end
  let(:eligible_csa_achievement) { create(:achievement, user_id: user.id, programme_id: cs_accelerator.id) }

  before do
    pp cs_enrolment
    cs_enrolment.transition_to(:complete)
    pp cs_enrolment
    pp eligible_csa_achievement
    eligible_csa_achievement.transition_to(:complete)
    pp eligible_csa_achievement
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
      task.execute
      expect(User.find(user.id).assessment_attempts).to be_empty
    end

    it 'unsets enrolment' do
      task.execute
      pp User.find(user.id).achievements.find(eligible_csa_achievement.id)
      pp cs_enrolment
      pp eligible_csa_achievement
      expect(User.find(user.id).user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id).complete?).to be_false
      # puts cs_enrolment
      # expect(cs_enrolment.complete?).to be_false
    end
  end
end
