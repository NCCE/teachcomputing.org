require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }
  let(:cpd_activity) { create(:activity, :cpd) }
  let(:cpd_courses) { create_list(:activity, 5, :cpd) }
  let(:future_learn_courses) { create_list(:activity, 3, :future_learn) }
  let(:user) { create(:user) }
  let(:user_achievement) { create(:achievement, user_id: user.id, activity_id: cpd_activity.id) }

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
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:category).in_array(['action', 'cpd']) }
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
  end

  describe 'class methods' do
    describe '#created_ncce_account' do
      it 'returns a record if one is found' do
        activity = create(:activity, :diagnostic_tool)
        expect(Activity.downloaded_diagnostic_tool).to eq activity
      end

      it 'creates a record if one is not found' do
        expect(Activity.downloaded_diagnostic_tool.title).to eq 'Downloaded diagnostic tool'
      end
    end
  end
end
