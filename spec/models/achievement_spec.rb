require 'rails_helper'

RSpec.describe Achievement, type: :model do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :my_learning) }
  let(:face_to_face_activity) { create(:activity, category: 'face-to-face') }
  let(:programme) { create(:programme) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity.id) }

  let(:achievement) { create(:achievement, activity_id: activity.id) }
  let(:achievement2) { create(:achievement, activity_id: face_to_face_activity.id) }
  let(:future_learn_achievement) { create(:achievement, :future_learn) }
  let(:completed_achievement) { create(:completed_achievement) }
  let(:diagnostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, activity: diagnostic_activity) }
  let(:community_activity) { create(:activity, :community) }
  let(:community_achievement) { create(:achievement, activity: community_activity) }

  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary_certificate) { create(:primary_certificate) }
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
    it { is_expected.to belong_to(:programme).optional(true) }
    it { is_expected.to have_many(:achievement_transitions) }
  end

  describe 'validations' do
    before do
      achievement
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:activity_id) }

    context 'valid file' do
      it 'is valid' do
        achievement.supporting_evidence.attach(
          io: File.open('spec/support/active_storage/supporting_evidence_test_upload.png'), filename: 'test.png', content_type: 'image/png'
        )
        expect(achievement.valid?).to be true
      end
    end

    context 'invalid file' do
      it 'is not valid' do
        achievement.supporting_evidence.attach(
          io: File.open('spec/support/active_storage/supporting_evidence_invalid_test_upload.txt'), filename: 'test.txt', content_type: 'text/plain'
        )
        expect(achievement.valid?).to be false
      end
    end
  end

  describe '#before_create' do
    it 'when activity has no programme does not set the programme_id' do
      expect(achievement.programme_id).to be_nil
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
        expect(achievement.programme_id).to be_nil
      end
    end

    it 'when we update the programme, the id is saved' do
      expect(diagnostic_achievement.programme).to be_nil
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

  describe '#with_provider' do
    before do
      achievement2
      future_learn_achievement
    end

    it 'returns the achievements which match the provider' do
      expect(Achievement.with_provider('stem-learning')).to include(achievement2)
    end

    it 'omits the achievements which don\'t match the provider' do
      expect(Achievement.with_provider('stem-learning')).not_to include(future_learn_achievement)
    end
  end

  describe '#complete!' do
    it 'when state is not complete' do
      expect { achievement.complete! }
        .to change(achievement, :complete?)
        .from(false).to(true)
    end

    it 'will save activity credit to the transition' do
      completed_achievement
      expect(completed_achievement.last_transition.metadata['credit']).to eq 100
    end

    it 'will save extra meta_data to the transition' do
      test_meta = '123'
      achievement.complete!(test: test_meta)
      expect(achievement.last_transition.metadata['test']).to eq test_meta
    end

    it 'when state is complete' do
      achievement.transition_to(:complete)
      expect(achievement.complete!).to be false
    end
  end

  describe '#drop!' do
    it 'sets state to dropped' do
      expect { achievement.drop! }
        .to change(achievement, :dropped?)
        .from(false).to(true)
    end

    it 'adds metadata if provided' do
      achievement.drop!(left_at: '123456')
      expect(achievement.last_transition.metadata)
        .to eq({ 'left_at' => '123456' })
    end
  end

  describe '#complete?' do
    it 'when state is not complete' do
      expect(achievement.complete?).to be false
    end

    it 'when state is complete' do
      expect(completed_achievement.complete?).to be true
    end
  end

  describe '#dropped?' do
    it 'returns false if not dropped' do
      expect(achievement.dropped?).to be false
    end

    it 'returns true if dropped' do
      dropped_achievement = create(:dropped_achievement)
      expect(dropped_achievement.dropped?).to be true
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

    it { is_expected.to delegate_method(:title).to(:activity).as(:title) }
    it { is_expected.to delegate_method(:stem_activity_code).to(:activity).as(:stem_activity_code) }
    it { is_expected.to delegate_method(:slug).to(:activity).as(:slug) }
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
        expect(achievement.primary_certificate?).to be(true)
      end
    end

    context 'when programme is not primary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.primary_certificate?).to be(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.primary_certificate?).to be(false)
      end
    end
  end

  describe '#cs_accelerator?' do
    context 'when programme is cs accelerator' do
      it 'returns true' do
        programme = build(:cs_accelerator)
        achievement = build(:achievement, programme: programme)
        expect(achievement.cs_accelerator?).to be(true)
      end
    end

    context 'when programme is not cs accelerator' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.cs_accelerator?).to be(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.cs_accelerator?).to be(false)
      end
    end
  end

  describe '#secondary_certificate?' do
    context 'when programme is secondary certificate' do
      it 'returns true' do
        programme = build(:secondary_certificate)
        achievement = build(:achievement, programme: programme)
        expect(achievement.secondary_certificate?).to be(true)
      end
    end

    context 'when programme is not secondary certificate' do
      it 'returns false' do
        programme = build(:programme, slug: 'another-programme-slug')
        achievement = build(:achievement, programme: programme)
        expect(achievement.secondary_certificate?).to be(false)
      end
    end

    context 'when programme is nil' do
      it 'returns false' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.secondary_certificate?).to be(false)
      end
    end
  end

  describe '#issue_badge' do
    context 'with badgeable is nil' do
      it 'returns nil' do
        achievement = build(:achievement, programme: nil)
        expect(achievement.issue_badge).to be_nil
      end
    end

    context 'without an enrolment' do
      it 'returns nil' do
        achievement = build(:achievement, programme:)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end
    end

    context 'with a programme, enrolment and an achievement count of 1' do
      let(:user) { create(:user, email: 'web@teachcomputing.org') }
      let(:badge) { create(:badge, :active, programme_id: cs_accelerator.id) }

      after do
        clear_enqueued_jobs
      end

      it 'queues Credly::IssueBadgeJob when the achievement is face-to-face' do
        stub_issue_badge(user.id, badge.credly_badge_template_id)
        stub_issued_badges_empty(user.id)

        achievement = create(:achievement, :face_to_face, programme_id: cs_accelerator.id, user_id: user.id)
        achievement.transition_to(:complete)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).to have_been_enqueued
      end

      it 'queues Credly::IssueBadgeJob when the achievement is remote' do
        stub_issue_badge(user.id, badge.credly_badge_template_id)
        stub_issued_badges_empty(user.id)

        achievement = create(:achievement, :remote, programme_id: cs_accelerator.id, user_id: user.id)
        achievement.transition_to(:complete)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).to have_been_enqueued
      end

      it 'does not queue if a badge already exists' do
        stub_issued_badges(user.id)

        achievement = create(:achievement, programme_id: cs_accelerator.id, user_id: user.id)
        achievement.transition_to(:complete)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end

      it 'does not queue if the achievement is online' do
        stub_issued_badges(user.id)

        achievement = create(:achievement, :online, programme_id: cs_accelerator.id, user_id: user.id)
        achievement.transition_to(:complete)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end

      it 'does not queue if the achievement is community' do
        stub_issued_badges(user.id)

        achievement = create(:achievement, :community, programme_id: cs_accelerator.id, user_id: user.id)
        achievement.transition_to(:complete)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end
    end

    context 'with a programme, enrolment and an achievement count of 0' do
      it 'returns nil and does not queue Credly::IssueBadgeJob' do
        achievement = create(:achievement, programme_id: cs_accelerator.id, user_id: user.id)
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end
    end

    context 'with a programme, enrolment and an achievement count greater than 1' do
      it 'returns nil and does not queue Credly::IssueBadgeJob' do
        3.times do
          achievement = create(:achievement, programme_id: cs_accelerator.id, user_id: user.id)
          achievement.transition_to(:complete)
        end
        create(:user_programme_enrolment,
               user:,
               programme: cs_accelerator)
        achievement.issue_badge
        expect(Credly::IssueBadgeJob).not_to have_been_enqueued
      end
    end
  end

  describe '#update_progress_and_state' do
    let(:achievement) { create(:achievement) }

    context 'when left_at is present' do
      it 'sets to dropped' do
        left_at = DateTime.now.to_s
        expect { achievement.update_progress_and_state(0, left_at) }
          .to change(achievement, :dropped?).to(true)
      end

      it 'does not set dropped if progress is 60 or over' do
        left_at = DateTime.now.to_s
        achievement.update_progress_and_state(60, left_at)
        expect(achievement.dropped?).to be(false)
      end
    end

    context 'when progress is 0' do
      it 'sets to enrolled' do
        achievement.update_progress_and_state(0, nil)
        expect(achievement.in_state?(:enrolled)).to be(true)
      end

      it 'sets progress to 0' do
        achievement.update_progress_and_state(0, nil)
        expect(achievement.progress).to eq(0)
      end

      it 'will enrol if achievement was previously dropped' do
        achievement.transition_to(:dropped)
        expect(achievement.dropped?).to be(true)
        achievement.update_progress_and_state(0, nil)
        expect(achievement.in_state?(:enrolled)).to be(true)
        expect(achievement.progress).to eq(0)
      end
    end

    context 'when progress between 1 and 59' do
      it 'sets to in progress and updates stored progress when progress is 1' do
        achievement.update_progress_and_state(1, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
        expect(achievement.progress).to eq(1)
      end

      it 'sets to in progress and updates stored progress when progress is 59' do
        achievement.update_progress_and_state(59, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
        expect(achievement.progress).to eq(59)
      end

      it 'sets progress to match value provided' do
        achievement.update_progress_and_state(49, nil)
        expect(achievement.progress).to eq(49)
      end

      it 'will set progress if achievement was previously dropped' do
        achievement.transition_to(:dropped)
        expect(achievement.dropped?).to be(true)
        achievement.update_progress_and_state(49, nil)
        expect(achievement.in_state?(:in_progress)).to be(true)
      end
    end

    context 'when progress between 60 and 100' do
      let(:achievement) { create(:achievement, activity: create(:activity, credit: 99)) }

      it 'sets to complete when progress is 60' do
        achievement.update_progress_and_state(60, nil)
        expect(achievement.complete?).to be(true)
        expect(achievement.last_transition.metadata)
          .to eq({ 'credit' => 99.0 })
        expect(achievement.progress).to eq(60)
      end

      it 'sets to complete when progress is 100' do
        achievement.update_progress_and_state(100, nil)
        expect(achievement.complete?).to be(true)
        expect(achievement.last_transition.metadata)
          .to eq({ 'credit' => 99.0 })
        expect(achievement.progress).to eq(100)
      end
    end

    context 'when progress is lower than saved progress' do
      let(:achievement) { create(:achievement, progress: 70) }

      it 'does not change saved progress value' do
        achievement.update_progress_and_state(60, nil)
        expect(achievement.progress).to eq(70)
      end
    end

    context 'when achievement is complete' do
      let(:achievement) { create(:completed_achievement, progress: 70) }

      it 'does not change state to dropped' do
        achievement.update_progress_and_state(80, DateTime.now.to_s)
        expect(achievement.complete?).to be(true)
      end

      it 'does not revert to in progress' do
        achievement.update_progress_and_state(50, nil)
        expect(achievement.complete?).to be(true)
      end

      it 'does update progress' do
        achievement.update_progress_and_state(75, nil)
        expect(achievement.progress).to eq(75)
      end
    end
  end

  describe '#queue_auto_enrolment' do
    context 'when course is part of csa' do
      let!(:achievement) { create(:achievement, activity: activity, user: user, programme: cs_accelerator) }

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
      before do
        create(
          :programme_activity,
          programme: primary_certificate,
          activity: activity
        )

        create(
          :programme_activity,
          programme: cs_accelerator,
          activity: activity
        )
      end

      context 'when achievement is connected to csa' do
        let!(:achievement) { create(:achievement, activity: activity, user: user, programme: cs_accelerator) }

        it 'queues job' do
          expect do
            achievement.reload.run_callbacks(:save)
          end.to have_enqueued_job(CSAccelerator::AutoEnrolJob)
        end
      end

      context 'when achievement not connected to csa' do
        let!(:achievement) { create(:achievement, activity: activity, user: user, programme: primary_certificate) }

        it 'does not queue job' do
          expect do
            achievement.reload.run_callbacks(:save)
          end.not_to have_enqueued_job(CSAccelerator::AutoEnrolJob)
        end
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
      let!(:achievement) { create(:achievement, activity: activity, user: user, programme: primary_certificate) }

      before do
        create(
          :programme_activity,
          programme: primary_certificate,
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
