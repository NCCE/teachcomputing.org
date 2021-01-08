require 'rails_helper'

RSpec.describe Achievement, type: :model do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, category: 'online') }
  let(:face_to_face_activity) { create(:activity, category: 'face-to-face') }
  let(:programme) { create(:programme) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity.id) }

  let(:achievement) { create(:achievement, activity_id: activity.id) }
  let(:achievement2) { create(:achievement, activity_id: face_to_face_activity.id) }
  let(:completed_achievement) { create(:completed_achievement) }
  let(:diagnostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, activity: diagnostic_activity) }
  let(:community_activity) { create(:activity, :community) }
  let(:community_achievement) { create(:achievement, activity: community_activity) }

  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:achievement_with_passed_programme_id) do
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, programme_id: cs_accelerator.id, activity_id: community_activity.id)
  end

  let(:achievement_with_programme) do
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, activity_id: community_activity.id)
  end

  let(:achievement_with_two_programmes) do
    face_to_face_activity = create(:activity, :stem_learning)
    create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
    create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
    create(:programme_activity, programme_id: programme.id, activity_id: face_to_face_activity.id)
    create(:programme_activity, programme_id: cs_accelerator.id, activity_id: face_to_face_activity.id)
    create(:achievement, activity_id: face_to_face_activity.id, user_id: user.id)
  end

  describe 'callbacks' do
    it { is_expected.to callback(:fill_in_programme_id).before(:create) }
    it { is_expected.to callback(:queue_auto_enrolment).after(:save) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:activity) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to have_many(:achievement_transitions) }
  end

  describe 'validations' do
    before do
      achievement
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:activity_id) }

    context 'valid file' do
      it 'is valid' do
<<<<<<< Updated upstream
        achievement.supporting_evidence.attach(
          io: File.open('spec/support/active_storage/supporting_evidence_test_upload.png'), filename: 'test.png', content_type: 'image/png'
        )
=======
        fix = file_fixture('supporting_evidence_test_upload.png')
        achievement.supporting_evidence = fix

>>>>>>> Stashed changes
        expect(achievement.valid?).to eq true
      end
    end

    context 'invalid file' do
      it 'is not valid' do
        achievement.supporting_evidence.attach(
          io: File.open('spec/support/active_storage/supporting_evidence_invalid_test_upload.txt'), filename: 'test.txt', content_type: 'text/plain'
        )
        expect(achievement.valid?).to eq false
      end
    end
  end

  describe '#before_create' do
    it 'when activity has no programme does not set the programme_id' do
      expect(achievement.programme_id).to be(nil)
    end

    it 'when programme_id is set, it is not overwritten' do
      expect(achievement_with_passed_programme_id.programme).to eq(cs_accelerator)
    end

    it 'when activity has a single programme it is used' do
      expect(achievement_with_programme.programme_id).to eq(programme.id)
    end

    context 'when activity has multiple programmes' do
      it 'gets the most recently enrolled one' do
        expect(achievement_with_two_programmes.programme).to eq(cs_accelerator)
      end

      it 'ignores a programme the user has unenrolled from' do
        face_to_face_activity = create(:activity, :stem_learning)
        create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
        csa_enrolment = create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
        csa_enrolment.transition_to(:unenrolled)

        create(:programme_activity, programme_id: programme.id, activity_id: face_to_face_activity.id)
        create(:programme_activity, programme_id: cs_accelerator.id, activity_id: face_to_face_activity.id)
        achievement = create(:achievement, activity_id: face_to_face_activity.id, user_id: user.id)
        expect(achievement.programme_id).to eq(programme.id)
      end

      it 'does not set id if user not enrolled on any programmes' do
        face_to_face_activity = create(:activity, :stem_learning)
        create(:programme_activity, programme_id: programme.id, activity_id: face_to_face_activity.id)
        create(:programme_activity, programme_id: cs_accelerator.id, activity_id: face_to_face_activity.id)
        achievement = create(:achievement, activity_id: face_to_face_activity.id, user_id: user.id)
        expect(achievement.programme_id).to eq(nil)
      end
    end

    it 'when we update the programme, the id is saved' do
      expect(diagnostic_achievement.programme).to eq(nil)
      diagnostic_achievement.programme = cs_accelerator
      diagnostic_achievement.save
      diagnostic_achievement.reload
      expect(diagnostic_achievement.programme_id).to eq(cs_accelerator.id)
    end
  end

  describe '#for_programme' do
    before do
      programme_activity
    end

    it 'when programme has matching activity it returns the achievement' do
      expect(Achievement.for_programme(programme)).to include(achievement)
    end

    it 'when programme doesn\'t have matching activity it doesn\'t return the achievement' do
      expect(Achievement.for_programme(programme)).not_to include(achievement2)
    end
  end

  describe '#with_category' do
    before do
      diagnostic_achievement
      achievement
    end

    it 'returns the achievements which match the category' do
      expect(Achievement.with_category(achievement.activity.category)).to include(achievement)
    end

    it 'omits the achievements which don\'t match the category' do
      expect(Achievement.with_category(achievement.activity.category)).not_to include(diagnostic_achievement)
    end
  end

  describe '#with_courses' do
    before do
      programme_activity
    end

    it 'includes face to face courses' do
      expect(Achievement.with_courses).to include(achievement)
    end

    it 'includes online courses' do
      expect(Achievement.with_courses).to include(achievement2)
    end

    it 'does not include any other category' do
      expect(Achievement.with_courses).not_to include(community_activity)
    end
  end

  describe '#with_credit' do
    before do
      diagnostic_achievement
      community_achievement
    end

    it 'returns the achievements which match the credit' do
      expect(Achievement.with_credit(10)).to include(community_achievement)
    end

    it 'omits the achievements which don\'t match the credit' do
      expect(Achievement.with_credit(10)).not_to include(diagnostic_achievement)
    end
  end

  describe '#without_category' do
    before do
      diagnostic_achievement
      achievement
    end

    it 'returns the achievements which match the category' do
      expect(Achievement.without_category(diagnostic_achievement.activity.category)).to include(achievement)
    end

    it 'omits the achievements which don\'t match the category' do
      expect(Achievement.without_category(diagnostic_achievement.activity.category)).not_to include(diagnostic_achievement)
    end
  end

  describe '#set_to_complete' do
    it 'when state is not complete' do
      achievement.set_to_complete
      expect(achievement.current_state).to eq 'complete'
    end

    it 'will save activity credit to the transition' do
      completed_achievement
      expect(completed_achievement.last_transition.metadata['credit']).to eq 100
    end

    it 'will save extra meta_data to the transition' do
      test_meta = '123'
      achievement.set_to_complete(test: test_meta)
      expect(achievement.last_transition.metadata['test']).to eq test_meta
    end

    it 'when state is complete' do
      achievement.transition_to(:complete)
      expect(achievement.set_to_complete).to eq false
    end
  end

  describe '#set_to_dropped' do
    it 'sets state to dropped' do
      achievement.set_to_dropped
      expect(achievement.current_state).to eq 'dropped'
    end
  end

  describe '#complete?' do
    it 'when state is not complete' do
      expect(achievement.complete?).to eq false
    end

    it 'when state is not complete' do
      expect(completed_achievement.complete?).to eq true
    end
  end

  describe '#dropped?' do
    it 'returns false if not dropped' do
      expect(achievement.dropped?).to eq false
    end

    it 'returns true if dropped' do
      dropped_achievement = create(:dropped_achievement)
      expect(dropped_achievement.dropped?).to eq true
    end
  end

  describe 'state' do
    context 'when default' do
      subject { Achievement.in_state(:enrolled) }

      it { is_expected.to include achievement }
    end

    context 'when completed' do
      subject { Achievement.in_state(:completed) }

      it { is_expected.not_to include achievement }
    end
  end

  describe 'delegate methods' do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
    it { is_expected.to delegate_method(:in_state?).to(:state_machine).as(:in_state?) }
  end

  describe 'destroy' do
    before do
      achievement
      achievement.transition_to(:complete)
    end

    it 'deletes transitions' do
      expect { achievement.destroy }.to change(AchievementTransition, :count).by(-1)
    end
  end

  describe '#primary_certificate?' do
    context 'when programme is primary certificate' do
      it 'returns true' do
        programme = build(:primary_certificate)
        achievement = build(:achievement, programme: programme)
        expect(achievement.primary_certificate?).to eq(true)
      end
    end

    context 'when programme is not primary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.primary_certificate?).to eq(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.primary_certificate?).to eq(false)
      end
    end
  end

  describe '#cs_accelerator?' do
    context 'when programme is cs accelerator' do
      it 'returns true' do
        programme = build(:cs_accelerator)
        achievement = build(:achievement, programme: programme)
        expect(achievement.cs_accelerator?).to eq(true)
      end
    end

    context 'when programme is not cs accelerator' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.cs_accelerator?).to eq(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.cs_accelerator?).to eq(false)
      end
    end
  end

  describe '#secondary_certificate?' do
    context 'when programme is secondary certificate' do
      it 'returns true' do
        programme = build(:secondary_certificate)
        achievement = build(:achievement, programme: programme)
        expect(achievement.secondary_certificate?).to eq(true)
      end
    end

    context 'when programme is not secondary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.secondary_certificate?).to eq(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.secondary_certificate?).to eq(false)
      end
    end
  end

  describe '#update_state_for_online_activity' do
    let(:achievement) { create(:achievement) }

    context 'when left_at is present' do
      it 'sets to dropped' do
        left_at = DateTime.now.to_s
        expect { achievement.update_state_for_online_activity(0, left_at) }
          .to change(achievement, :dropped?).to(true)
      end

      it 'does not set dropped if progress is 60 or over' do
        left_at = DateTime.now.to_s
        achievement.update_state_for_online_activity(60, left_at)
        expect(achievement.dropped?).to eq(false)
      end
    end

    context 'when progress is 0' do
      it 'sets to enrolled' do
        achievement.update_state_for_online_activity(0, nil)
        expect(achievement.in_state?(:enrolled)).to eq(true)
      end
    end

    context 'when progress between 1 and 59' do
      it 'sets to in progress with metadata when progress is 1' do
        achievement.update_state_for_online_activity(1, nil)
        expect(achievement.in_state?(:in_progress)).to eq(true)
        expect(achievement.last_transition.metadata).to eq({ 'progress' => 1 })
      end

      it 'sets to in progress with metadata when progress is 59' do
        achievement.update_state_for_online_activity(59, nil)
        expect(achievement.in_state?(:in_progress)).to eq(true)
        expect(achievement.last_transition.metadata).to eq({ 'progress' => 59 })
      end
    end

    context 'when progress between 60 and 100' do
      let(:achievement) { create(:achievement, activity: create(:activity, credit: 99)) }

      it 'sets to complete when progress is 60' do
        achievement.update_state_for_online_activity(60, nil)
        expect(achievement.complete?).to eq(true)
        expect(achievement.last_transition.metadata)
          .to eq({ 'credit' => 99.0, 'progress' => 60 })
      end

      it 'sets to complete when progress is 100' do
        achievement.update_state_for_online_activity(100, nil)
        expect(achievement.complete?).to eq(true)
        expect(achievement.last_transition.metadata)
          .to eq({ 'credit' => 99.0, 'progress' => 100 })
      end
    end

    it 'does not change state if achievement is complete' do
      achievement = create(:completed_achievement)
      achievement.update_state_for_online_activity(40, DateTime.now.to_s)
      expect(achievement.complete?).to eq(true)
    end
  end

  describe '#queue_auto_enrolment' do
    context 'when course is part of csa' do
      let!(:achievement) { create(:achievement, activity: activity, user: user) }

      before do
        create(:programme_activity, programme: cs_accelerator, activity: activity)
      end

      it 'queues job' do
        expect do
          achievement.reload.run_callbacks(:save)
        end.to have_enqueued_job(CSAccelerator::AutoEnrolJob)
          .with(achievement_id: achievement.id)
      end

      context 'when user is enrolled on CSAccelerator' do
        it 'does not queue job' do
          create(:user_programme_enrolment,
                 user: user,
                 programme: cs_accelerator)
          expect do
            achievement.reload.run_callbacks(:save)
          end.not_to have_enqueued_job(CSAccelerator::AutoEnrolJob)
        end
      end
    end

    context 'when course is part of csa and another programme' do
      let!(:achievement) { create(:achievement, activity: activity, user: user) }

      before do
        create(
          :programme_activity,
          programme: create(:primary_certificate),
          activity: activity
        )

        create(
          :programme_activity,
          programme: cs_accelerator,
          activity: activity
        )
      end

      it 'queues job' do
        expect do
          achievement.reload.run_callbacks(:save)
        end.to have_enqueued_job(CSAccelerator::AutoEnrolJob)
      end

      context 'when user is enrolled on CSAccelerator' do
        it 'does not queue job' do
          create(:user_programme_enrolment,
                 user: user,
                 programme: cs_accelerator)
          expect do
            achievement.reload.run_callbacks(:save)
          end.not_to have_enqueued_job(CSAccelerator::AutoEnrolJob)
        end
      end
    end

    context 'when course is not part of csa' do
      let!(:achievement) { create(:achievement, activity: activity, user: user) }

      before do
        create(
          :programme_activity,
          programme: create(:primary_certificate),
          activity: activity
        )
      end

      it 'does not queue job' do
        expect do
          achievement.reload.run_callbacks(:save)
        end.not_to have_enqueued_job(CSAccelerator::AutoEnrolJob)
      end
    end
  end
end
