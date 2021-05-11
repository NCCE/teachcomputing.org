require 'rails_helper'

RSpec.describe('certificates/_achievements', type: :view) do
  let(:stem_id_activity) { create(:activity, stem_activity_code: 'CP123') }
  let(:stem_id_achievement) { create(:achievement, activity: stem_id_activity) }

  let(:no_stem_id_activity) { create(:activity, stem_activity_code: nil) }
  let(:no_stem_id_achievement) { create(:achievement, activity: no_stem_id_activity) }

  it 'links to activity if it has stem_activity_code' do
    render partial: 'certificates/cs_accelerator/achievements',
           locals: {
             non_compulsory_achievements: [stem_id_achievement],
             compulsory_achievement: nil,
             user_completed_non_compulsory_achievement: false
           }
    expect(rendered).to have_link(stem_id_achievement.title)
  end

  it 'does not error if achievement has no stem id' do
    render partial: 'certificates/cs_accelerator/achievements',
           locals: {
             non_compulsory_achievements: [no_stem_id_achievement],
             compulsory_achievement: nil,
             user_completed_non_compulsory_achievement: false
           }
    expect(rendered).to include(no_stem_id_achievement.title)
  end
end
