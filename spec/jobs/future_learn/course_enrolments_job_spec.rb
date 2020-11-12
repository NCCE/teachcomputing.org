require 'rails_helper'

RSpec.describe FutureLearn::CourseEnrolmentsJob, type: :job do
  subject(:run_job) do
    described_class.perform_now(course_uuid: course_uuid,
                                run_uuids: [run1_uuid, run2_uuid])
  end

  let(:course_uuid) { '621a6593-9b37-47a8-a9b5-e840e6b66fbe' }
  let(:run1_uuid) { 'd2acdb39-f6cb-45da-8c37-681d3b4d2911' }
  let(:run2_uuid) { 'd2acdb39-f6cb-45da-8c37-681d3b4d2912' }
  let(:membership_id) { '0ea0e41f-5620-4a91-a1c7-2a15ecf16a06' }
  let(:multiple_id_membership_id1) { 'e59a11cd-41dd-404d-939e-a06d9788d9e4' }
  let(:multiple_id_membership_id2) { '53e76dd8-9431-40bd-abaa-7cb71fec16e6' }

  let(:user_enrolment_run1) do
    build(:fl_enrolment,
          run_uuid: run1_uuid,
          membership_uuid: membership_id,
          activated_at: (DateTime.now - 2.weeks).to_s)
  end

  let(:user_enrolment_run2) do
    build(:fl_enrolment,
          run_uuid: run2_uuid,
          membership_uuid: membership_id,
          activated_at: (DateTime.now - 3.days).to_s)
  end

  let(:run1_multiple_id_user_enrolment1) do
    build(:fl_enrolment,
          run_uuid: run1_uuid,
          membership_uuid: multiple_id_membership_id1,
          activated_at: (DateTime.now - 2.weeks).to_s)
  end

  let(:run1_multiple_id_user_enrolment2) do
    build(:fl_enrolment,
          run_uuid: run1_uuid,
          membership_uuid: multiple_id_membership_id2,
          activated_at: (DateTime.now - 1.weeks).to_s)
  end

  before do
    run1_enrolments = build_list(:fl_enrolment, 3, run_uuid: run1_uuid)
    run1_enrolments << user_enrolment_run1
    run1_enrolments << run1_multiple_id_user_enrolment1
    run1_enrolments << run1_multiple_id_user_enrolment2

    run2_enrolments = build_list(:fl_enrolment, 2, run_uuid: run2_uuid)
    run2_enrolments << user_enrolment_run2

    allow(FutureLearn::Queries::CourseEnrolments)
      .to receive(:all)
      .with(run1_uuid)
      .and_return(run1_enrolments)
    allow(FutureLearn::Queries::CourseEnrolments)
      .to receive(:all)
      .with(run2_uuid)
      .and_return(run2_enrolments)
  end

  describe '.perform' do
    context 'when we have future_learn_organisation_membership_uuid in db' do
      before do
        create(
          :user,
          future_learn_organisation_memberships: [membership_id]
        )
      end

      it 'queues job to update users activity with latest run information' do
        expect { run_job }
          .to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
          .with(course_uuid: course_uuid, enrolment: user_enrolment_run2)
          .once
      end
    end

    context 'when user has two membership_ids on runs of the same course' do
      before do
        create(
          :user,
          future_learn_organisation_memberships: [multiple_id_membership_id1, multiple_id_membership_id2]
        )
      end

      it 'queues job to update users activity with latest run information' do
        expect { run_job }
          .to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
          .with(course_uuid: course_uuid, enrolment: run1_multiple_id_user_enrolment2)
          .once
      end

      it 'does not queue job to update users activity with oldest run of multiple ids' do
        expect { run_job }
          .not_to have_enqueued_job(FutureLearn::UpdateUserActivityJob)
          .with(course_uuid: course_uuid, enrolment: run1_multiple_id_user_enrolment1)
      end
    end
  end
end
