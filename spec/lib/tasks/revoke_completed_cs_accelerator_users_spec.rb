# frozen_string_literal: true

require 'rails_helper'
require 'csv'
require 'rake'

RSpec.describe 'rake csa:revoke', type: :task do
  let(:csv_path) { 'csa_revoke.csv' }
  let(:user) { create(:user) }
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
      task.execute
      expect(user.assessment_attempts).to be_empty
    end
  end
end
