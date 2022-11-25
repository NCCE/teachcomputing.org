require 'rails_helper'

RSpec.describe CSAcceleratorEligibleCoursesForSecondaryCertificateUserJob do
  let(:user) { create(:user) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:cs_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }
  let!(:additional_csa_activity) { create(:activity, slug: 'complete-a-cs-accelerator-course') }
  let(:additional_csa_achievement_for_secondary) do
    create(:achievement, activity_id: additional_csa_activity.id, user_id: user.id,
                         programme_id: secondary_certificate.id)
  end
  let(:eligible_csa_achievement) { create(:achievement, user_id: user.id, programme_id: cs_accelerator.id) }

  describe '#perform' do
    before do
      create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id)
    end

    context 'when the user already has the additional CSA achievement' do
      it 'does not create an achievement for the user' do
        additional_csa_achievement_for_secondary
        expect { described_class.perform_now(user.id) }.not_to change(user.achievements, :count)
      end
    end

    context 'when the user does not already have the additional CSA achievement' do
      before do
        cs_enrolment.transition_to(:complete)
      end

      context 'when the user has done an eligible CSA course' do
        before do
          eligible_csa_achievement.transition_to(:complete)
        end

        it 'creates creates an achievement for the user' do
          expect { described_class.perform_now(user.id) }.to change { user.achievements.count }.by(1)
        end
      end

      context 'when the user has not done an eligible CSA course' do
        it 'does not create an achievement for the user' do
          expect { described_class.perform_now(user.id) }.not_to change(user.achievements, :count)
        end
      end
    end
  end
end
