require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }
  let(:cpd_activity) { create(:activity, :cpd) }
  let(:cpd_courses) { create_list(:activity, 5, :cpd) }
  let(:future_learn_courses) { create_list(:activity, 3, :future_learn) }
  let(:system_activity) { create_list(:activity, 3, :system) }
  let(:user) { create(:user) }
  let(:user_achievement) { create(:achievement, user_id: user.id, activity_id: cpd_activity.id) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:removable_activity) { create(:activity, :user_removable) }

  describe 'associations' do
    it 'has_many achievements' do
      expect(activity).to have_many(:achievements)
    end

    it 'has_many users' do
      expect(activity).to have_many(:users).through(:achievements)
    end

    it 'has_many imports' do
      expect(activity).to have_many(:imports)
    end

    it 'has_many programmes' do
      expect(activity).to have_many(:programmes).through(:programme_activities)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:category).in_array(%w[action cpd]) }
  end

  describe 'scopes' do
    describe 'available_for' do
      before do
        [cpd_activity, cpd_courses, user, user_achievement]
      end

      it 'lists available cpd activities for a given user' do
        expect(Activity.available_for(user)).to eq(cpd_courses)
      end

      it 'does not include activities if a user already has an existing achievement' do
        expect(Activity.available_for(user)).not_to include(cpd_activity)
      end
    end

    describe 'cpd' do
      before do
        [cpd_courses, activity]
      end

      it 'includes only cpd activities' do
        expect(Activity.cpd).to eq(cpd_courses)
      end

      it 'does not include actions' do
        expect(Activity.cpd).not_to include(activity)
      end
    end

    describe 'future-learn' do
      before do
        [future_learn_courses, activity]
      end

      it 'includes only cpd activities' do
        expect(Activity.future_learn).to eq(future_learn_courses)
      end

      it 'does not include actions' do
        expect(Activity.future_learn).not_to include(activity)
      end
    end

    describe 'system' do
      before do
        [system_activity, activity]
      end

      it 'includes only system activities' do
        expect(Activity.system).to eq(system_activity)
      end

      it 'does not include actions' do
        expect(Activity.system).not_to include(activity)
      end
    end

    describe 'user_removable' do
      before do
        [removable_activity, activity, diagnostic_tool_activity]
      end

      it 'include future-learn activities' do
        expect(Activity.user_removable).to include(removable_activity)
      end

      it 'does not include stem' do
        expect(Activity.user_removable).not_to include(activity)
      end

      it 'does not include diagnostic download' do
        expect(Activity.user_removable).not_to include(diagnostic_tool_activity)
      end
    end
  end

  describe 'class methods' do
    describe '#diagnostic_tool' do
      it 'returns a record if one is found' do
        activity = create(:activity, :diagnostic_tool)
        expect(Activity.diagnostic_tool).to eq activity
      end

      it 'creates a record if one is not found' do
        expect(Activity.diagnostic_tool.title).to eq 'Taken diagnostic tool'
      end
    end
  end

  describe 'registered_with_the_national_centre' do
    it 'returns a record if one is found' do
      activity = create(:activity, :registered_with_national_centre)
      expect(Activity.registered_with_the_national_centre).to eq activity
    end

    it 'creates a record if one is not found' do
      expect(Activity.registered_with_the_national_centre.title).to eq 'Registered with the National Centre'
    end

    it 'has a credit weighting of 5' do
      expect(Activity.registered_with_the_national_centre.credit).to eq 5
    end
  end
end
