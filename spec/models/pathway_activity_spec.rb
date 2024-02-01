require "rails_helper"

RSpec.describe PathwayActivity, type: :model do
  let(:activity) { create(:activity, category: "online") }
  let(:pathway_activity) { create(:pathway_activity, activity_id: activity.id) }

  it { is_expected.to belong_to(:pathway) }
  it { is_expected.to belong_to(:activity) }

  it { is_expected.to delegate_method(:title).to(:activity).as(:title) }
  it { is_expected.to delegate_method(:stem_activity_code).to(:activity).as(:stem_activity_code) }
  it { is_expected.to delegate_method(:slug).to(:activity).as(:slug) }
  it { is_expected.to delegate_method(:category).to(:activity).as(:category) }
  it { is_expected.to delegate_method(:online?).to(:activity).as(:online?) }
  it { is_expected.to delegate_method(:remote_delivered_cpd?).to(:activity).as(:remote_delivered_cpd?) }
end
