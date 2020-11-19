require 'rails_helper'

RSpec.describe FutureLearn::UpdateUserActivityJob, type: :job do
  describe '.perform' do
    subject(:run_job) do
      described_class.perform_now(course_uuid: course_uuid,
                                  enrolment: enrolment)
    end

    let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
    let(:run_uuid) { 'd2acdb39-f6cb-45da-8c37-681d3b4d2911' }
    let(:membership_id) { '0ea0e41f-5620-4a91-a1c7-2a15ecf16a06' }
    let!(:activity) { create(:activity, future_learn_course_uuid: course_uuid) }
    let(:mock_instance) { instance_double(Achievement) }
    let(:primary_certificate) { create(:primary_certificate) }
    let(:secondary_certificate) { create(:secondary_certificate) }

    let!(:user) do
      create(:user, future_learn_organisation_memberships: [membership_id])
    end

    let(:enrolment) do
      build(:fl_enrolment, run_uuid: run_uuid, membership_uuid: membership_id)
    end

    context 'when user has a matching achievement' do
      let!(:achievement) { create(:achievement, user: user, activity: activity) }

      it 'does not create a new achievement for the user' do
        expect { run_job }.not_to change(Achievement, :count)
      end

      it 'updates status for achievement' do
        mock_achievement
        run_job
        expect(mock_instance)
          .to have_received(:update_state_for_online_activity)
          .with(enrolment[:steps_completed_count].to_f,
                enrolment[:deactivated_at])
      end
    end

    context 'when user does not have a matching achievement' do
      it 'creates a matching achievement for the user' do
        expect { run_job }.to change(Achievement, :count).by(1)
        new_achievement = Achievement.last
        expect(new_achievement.user_id).to eq(user.id)
        expect(new_achievement.activity_id).to eq(activity.id)
      end

      it 'updates status for achievement' do
        mock_achievement
        run_job
        expect(mock_instance)
          .to have_received(:update_state_for_online_activity)
          .with(enrolment[:steps_completed_count].to_f,
                enrolment[:deactivated_at])
      end
    end

    context 'when achievement is for primary certificate programme' do
      before do
        create(:achievement,
               user: user,
               activity: activity,
               programme: primary_certificate)
      end

      context "when user's achievement is updated to complete" do
        let(:enrolment) do
          build(:fl_enrolment,
                run_uuid: run_uuid,
                membership_uuid: membership_id,
                steps_completed_count: 90)
        end

        it 'queues CertificatePendingTransitionJob' do
          expect { run_job }
            .to have_enqueued_job(CertificatePendingTransitionJob)
            .with(primary_certificate, user.id, source: 'FutureLearn::UpdateUserActivityJob')
            .once
        end
      end
    end

    context 'when achievement is for cs accelerator programme' do
      before do
        create(:achievement,
               user: user,
               activity: activity,
               programme: create(:cs_accelerator_programme))
      end

      context "when user's achievement is updated to complete" do
        let(:enrolment) do
          build(:fl_enrolment,
                run_uuid: run_uuid,
                membership_uuid: membership_id,
                steps_completed_count: 90)
        end

        it 'queues AssessmentEligibilityJob' do
          expect { run_job }
            .to have_enqueued_job(AssessmentEligibilityJob)
            .with(user.id)
            .once
        end
      end
    end

    context 'when achievement is for secondary certificate programme' do
      before do
        create(:achievement,
               user: user,
               activity: activity,
               programme: secondary_certificate)
      end

      context "when user's achievement is updated to complete" do
        let(:enrolment) do
          build(:fl_enrolment,
                run_uuid: run_uuid,
                membership_uuid: membership_id,
                steps_completed_count: 77)
        end

        it 'queues CertificatePendingTransitionJob' do
          expect { run_job }
            .to have_enqueued_job(CertificatePendingTransitionJob)
            .with(secondary_certificate, user.id, source: 'FutureLearn::UpdateUserActivityJob')
            .once
        end
      end
    end

    context "when user's achievement is already complete" do
      it 'does not update status' do
        mock_complete_achievement
        run_job
        expect(mock_instance)
          .not_to have_received(:update_state_for_online_activity)
      end
    end
  end

  def mock_achievement
    allow(Achievement).to receive(:find_or_create_by).and_return(mock_instance)
    allow(mock_instance).to receive(:complete?)
    allow(mock_instance).to receive(:update_state_for_online_activity)
    allow(mock_instance).to receive(:primary_certificate?)
    allow(mock_instance).to receive(:secondary_certificate?)
    allow(mock_instance).to receive(:cs_accelerator?)
  end

  def mock_complete_achievement
    mock_achievement
    allow(mock_instance).to receive(:complete?).and_return(true)
  end
end
