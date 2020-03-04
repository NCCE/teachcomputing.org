require 'rails_helper'

RSpec.describe Achievement, type: :model do
  let(:user) { create(:user) }
  let(:achievement) { create(:achievement) }
  let(:achievement2) { create(:achievement) }
  let(:completed_achievement) { create(:completed_achievement) }
  let(:diagnostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, activity: diagnostic_activity) }
  let(:community_activity) { create(:activity, :community) }
  let(:community_achievement) { create(:achievement, activity: community_activity) }

  let(:programme) { create(:programme) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: achievement.activity_id) }

  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:achievement_with_passed_programme_id) {
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, programme_id: cs_accelerator.id, activity_id: community_activity.id)
  }

  let(:achievement_with_programme) {
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
    create(:achievement, activity_id: community_activity.id)
  }

  let(:achievement_with_two_programmes) {
    face_to_face_activity = create(:activity, :stem_learning)
    create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
    create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
    create(:programme_activity, programme_id: programme.id, activity_id: face_to_face_activity.id)
    create(:programme_activity, programme_id: cs_accelerator.id, activity_id: face_to_face_activity.id)
    create(:achievement, activity_id: face_to_face_activity.id, user_id: user.id)
  }

  describe 'associations' do
    it 'belongs to activity' do
      expect(achievement).to belong_to(:activity)
    end

    it 'belongs to user' do
      expect(achievement).to belong_to(:user)
    end

    it 'belongs to programme' do
      expect(achievement).to belong_to(:programme)
    end
  end

  describe 'validations' do
    before do
      achievement
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:activity_id) }
  end

  describe '#before_create' do
    it 'when activity has no programme does not set the programme_id' do
      expect(achievement.programme_id).to be(nil)
    end

    it 'when programme_id is set, it is not overwritten' do
      expect(achievement_with_passed_programme_id.programme).to eq(cs_accelerator)
    end

    it 'when activity has a single programme it is used' do
      expect(achievement_with_programme.programme).to eq(programme)
    end

    it 'when activity has multiple programmes it gets the most recently enrolled one' do
      expect(achievement_with_two_programmes.programme).to eq(cs_accelerator)
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
      expect(Achievement.with_category(achievement.activity.category)).to_not include(diagnostic_achievement)
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
      expect(Achievement.with_credit(10)).to_not include(diagnostic_achievement)
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
      expect(Achievement.without_category(diagnostic_achievement.activity.category)).to_not include(diagnostic_achievement)
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

  describe '#complete?' do
    it 'when state is not complete' do
      expect(achievement.complete?).to eq false
    end

    it 'when state is not complete' do
      expect(completed_achievement.complete?).to eq true
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
  end

  describe 'destroy' do
    before do
      achievement
      achievement.transition_to(:complete)
    end

    it 'deletes transitions' do
      expect { achievement.destroy }.to change { AchievementTransition.count }.by(-1)
    end
  end
end
